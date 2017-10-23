import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Flow {
    property var eeParameterData
    spacing: 20
    flow: Flow.LeftToRight
    Repeater {
        id: repeaterBitmap
        model: eeParameterData.count
        GridLayout {
            flow: eeParameterData.horizontaldata ? GridLayout.LeftToRight : GridLayout.TopToBottom
            rows: eeParameterData.rows
            columns: eeParameterData.columns
            rowSpacing: 3
            columnSpacing: 3
            width: (20 + rowSpacing) * columns
            height: (20 + columnSpacing) * rows
            property alias repeaterDot: repeaterDot
            Repeater {
                id: repeaterDot
                model: eeParameterData.rows * eeParameterData.columns
                Rectangle {
                    property bool on: false
                    width: 20
                    height: width
                    radius: width / 2
                    color: on ? globStyle.accent : "black"
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
        var dotsPerBitmap = eeParameterData.rows * eeParameterData.columns;
        vals.length = dotsPerBitmap * eeParameterData.count / 8
        for (var vi = 0; vi < vals.length; vi++)
            vals[vi] = 0
        for (var bm = 0; bm < eeParameterData.count; bm++){
            var repeaterDot = repeaterBitmap.itemAt(bm).repeaterDot
            for (var d = 0; d < dotsPerBitmap; d++){
                var valIndex = Math.floor(d / 8) + (dotsPerBitmap / 8) * bm
                vals[valIndex] |= repeaterDot.itemAt(d).on << (7 - d % 8)
            }
        }
        return vals
    }

    function setParameterValue(vals) {
        var dotsPerBitmap = eeParameterData.rows * eeParameterData.columns;
        for (var bm = 0; bm < eeParameterData.count; bm++){
            var repeaterDot = repeaterBitmap.itemAt(bm).repeaterDot
            for (var d = 0; d < dotsPerBitmap; d++){
                var valIndex = Math.floor(d / 8) + (dotsPerBitmap / 8) * bm
                repeaterDot.itemAt(d).on = (vals[valIndex] << (d % 8)) & (1 << 7)
            }
        }
    }

}
