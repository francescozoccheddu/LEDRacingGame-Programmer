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


    function getParameterValue() {
        var vals = []
        var rows = eeParameterData.horizontaldata ? eeParameterData.columns : eeParameterData.rows
        var cols = eeParameterData.horizontaldata ? eeParameterData.rows : eeParameterData.columns
        for (var bm = 0; bm < eeParameterData.count; bm++) {
            var bitmap = repeaterBitmap.itemAt(bm);
            var bc = Math.ceil(rows / 8)
            for (var dx = 0; dx < cols; dx++) {
                for (var b = 0; b < bc; b++) {
                    var val = 0
                    for (var bi = 0; bi < 8; bi++) {
                        var dy = b * 8 + bi
                        var di = eeParameterData.horizontaldata ? (dx * cols + dy) : (dx + dy * cols)
                        val <<= 1;
                        val |= dy < rows ? bitmap.repeaterDot.itemAt(di).on : 0
                    }
                    vals.push(val)
                }
            }
        }
        return vals
    }

    function setParameterValue(parameterValue) {

    }

}
