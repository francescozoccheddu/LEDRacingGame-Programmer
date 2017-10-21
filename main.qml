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
            model: JSON.parse(fileIO.read("C:/Users/zocch/Desktop/test.json"))
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
            informativeText = messageExt
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
            if (task.busy)
                return task.writing ? (task.counter / task.data.length) : (task.data.length / task.counter)
            else
                return 0
        }

        QtObject {
            id: task
            property bool busy
            property bool writing
            property int address
            property var data
            property int counter
            property int phase

            function process(data) {

            }
        }

        function write(address, data) {
            if (task.busy)
                throw new Error("Already busy")
            task.busy = true
            task.writing = true
            task.address = address
            task.data = data
            task.counter = 0
            task.phase = 0

            task.process(data)
        }

        function read(address, size, onReadComplete) {
            if (task.busy)
                throw new Error("Already busy")
            task.busy = true
            task.writing = false
            task.address = address
            task.data = []
            task.counter = size
            task.phase = 0

            task.process(data)
        }

        Connections {
            target: serialIO
            onIncoming: {
                if (data.lenght === 1 && task.busy)
                    task.process(data[0]);
                else {
                    serialIO.open = false
                    serialError.error("Unexpected data")
                }
            }
            onOpenChanged: {
                if (serialIO.open) {
                    task.busy = true
                    task.data = []
                    task.counter = 0
                    task.writing = true
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
