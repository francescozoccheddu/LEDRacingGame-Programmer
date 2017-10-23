import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2

ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    ColumnLayout {
        anchors.fill: parent

        AList {
            id: parSelector
            model: JSON.parse(fileIO.read("eeParameters.json"))
            Layout.preferredHeight: 65535
            Layout.preferredWidth: 65535
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        ADeviceBar {
            id: deviceBar
            Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
            Layout.fillHeight: false
            Layout.fillWidth: true
            Layout.preferredWidth: 65535
        }
    }


    MessageDialog {
        id: serialError
        title: "Serial port error"
        icon: StandardIcon.Warning
        standardButtons: StandardButton.Ignore

        function error(message, messageExt) {
            text = message
            informativeText = typeof messageExt === "undefined" ? "" : messageExt
            visible = true
        }
    }

    Item {
        id: serialTask
        visible: false

        function isBusy() {
            return task.busy
        }

        function getProgress() {
            if (task.waiting)
                return timer.progress
            else {
                var top = task.writing ? task.data.length : (task.counter + task.data.length)
                var curr = task.writing ? task.counter : task.data.length
                var step = 1 / top
                return (curr / top) + timer.progress * step
            }
        }

        Timer {
            id: timer
            interval: 500
            repeat: false
            running: task.busy
            onTriggered: {
                serialIO.open = false
                serialError.error("Request timed out")
            }

            property real progress

            NumberAnimation on progress{
                id: timerAnimation
                from: 0
                to: 1
                duration: timer.interval
            }

            function start() {
                restart()
                timerAnimation.restart()
            }
        }


        QtObject {
            id: task
            property bool busy
            property bool waiting
            property bool writing
            property int address
            property var data
            property int counter
            property int phase
            property var onReadyComplete

            function process(incoming) {
                if (waiting) {
                    if (incoming !== 0) {
                        serialIO.open = false
                        serialError.error("Opening failed", "Unknown start code message")
                    }
                    else {
                        busy = false
                        waiting = false
                    }
                }
                else {
                    if (writing) {
                        if (counter < data.length){
                            switch(phase) {
                            case 0:
                                serialIO.write((address + counter) & 0xFF)
                                break
                            case 1:
                                serialIO.write(((address + counter) >> 8) | (1 << 7))
                                break
                            case 2:
                                serialIO.write(data[counter++])
                                break
                            }
                            phase = (phase + 1) % 3
                        }
                        else {
                            serialIO.open = false
                            serialIO.open = true
                        }
                    }
                    else {
                        if (phase == 2) {
                            data.push(incoming)
                            if (--counter <= 0){
                                busy = false
                                onReadyComplete(data)
                                return
                            }
                        }
                        switch(phase % 2) {
                        case 0:
                            serialIO.write((address + data.length) & 0xFF)
                            phase = 1
                            break
                        case 1:
                            serialIO.write((address + data.length) >> 8)
                            phase = 2
                            break
                        }
                    }
                }
            }
        }

        function write(address, data) {
            if (task.busy)
                throw new Error("Already busy")
            task.writing = true
            task.address = address
            task.data = data
            task.counter = 0
            task.phase = 0
            task.busy = true

            task.process()
        }

        function read(address, size, onReadComplete) {
            if (task.busy)
                throw new Error("Already busy")
            task.writing = false
            task.address = address
            task.data = []
            task.counter = size
            task.phase = 0
            task.busy = true
            task.onReadyComplete = onReadComplete

            task.process()
        }

        Connections {
            target: serialIO
            onIncoming: {
                if (task.busy) {
                    timer.start()
                    task.process(data)
                }
                else {
                    serialIO.open = false
                    serialError.error("Unexpected data")
                }
            }
            onOpenChanged: {
                if (serialIO.open) {
                    task.waiting = true
                    task.busy = true
                    timer.start()
                }
                else
                    task.busy = false
            }
            onError: {
                serialIO.open = false
                serialError.error(message, messageExt)
            }
        }

    }

}
