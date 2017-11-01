import QtQuick 2.0

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

    function describe() {
        if (task.busy) {
            if (task.waiting)
                return "Waiting for start message"
            else {
                if (task.writing)
                    return "%1 of %2 bytes written to address %3".arg(task.counter, task.data.length, task.address)
                else
                    return "%1 of %2 bytes read from address %3".arg(task.data.length, task.counter + task.data.length, task.address)
            }
        }
        else
            return serialIO.open ? "Connected" : "Disconnected"
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
