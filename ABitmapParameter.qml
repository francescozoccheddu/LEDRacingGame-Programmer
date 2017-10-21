import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

ColumnLayout {
    property var eeParameterData
    Repeater {
        id: repeaterBitmap
        model: eeParameterData.count
        GridLayout {
            rows: eeParameterData.rows
            columns: eeParameterData.columns
            property alias repeaterDot: repeaterDot
            Repeater {
                id: repeaterDot
                model: eeParameterData.rows * eeParameterData.columns
                Rectangle {
                    property bool on: false
                    width: 20
                    height: width
                    radius: width / 2
                    color: on ? "red" : "black"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            on = !on
                        }
                    }
                }
            }

        }
    }

    function getDot(repeater, index) {
        if (eeParameterData.horizontaldata)
            return repeater.itemAt(index)
        else {
            var cols = eeParameterData.columns
            var y = parseInt(index / cols)
            var x = index % cols
            return repeater.itemAt(x * cols + y)
        }
    }

    function getParameterValue() {
        var vals = []
        for (var bm = 0; bm < eeParameterData.count; bm++) {
            var repeater = repeaterBitmap.itemAt(bm).repeaterDot
            var dots = eeParameterData.rows * eeParameterData.columns
            for (var by = 0; by < dots / 8; by++){
                var val = 0
                for (var b = 0; b < 8; b++) {
                    val = (val << 1) | getDot(repeater, by * 8 + b).on
                }
                vals.push(val)
            }
        }
        return vals
    }

    function setParameterValue(vals) {
        for (var bm = 0; bm < eeParameterData.count; bm++) {
            var repeater = repeaterBitmap.itemAt(bm).repeaterDot
            var dots = eeParameterData.rows * eeParameterData.columns
            for (var by = 0; by < dots / 8; by++){
                var val = vals[by]
                for (var b = 0; b < 8; b++) {
                    getDot(repeater, by * 8 + b).on = !!(val & (1<<7))
                    val <<= 1
                }
            }
        }
    }

}
