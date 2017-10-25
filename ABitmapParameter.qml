import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Flow {
    property var eeParameterData
    spacing: globStyle.size * 0.4
    flow: Flow.LeftToRight
    Repeater {
        id: repeaterBitmap
        model: eeParameterData.count
        GridLayout {
            property real dotSize: globStyle.size * 0.5
            flow: eeParameterData.horizontaldata ? GridLayout.LeftToRight : GridLayout.TopToBottom
            rows: eeParameterData.rows
            columns: eeParameterData.columns
            rowSpacing: globStyle.size * 0.05
            columnSpacing: rowSpacing
            width: (dotSize + rowSpacing) * columns
            height: (dotSize + columnSpacing) * rows
            property alias repeaterDot: repeaterDot
            Repeater {
                id: repeaterDot
                model: eeParameterData.rows * eeParameterData.columns
                Rectangle {
                    property bool on: false
                    width: dotSize
                    height: width
                    radius: width / 2
                    color: {
                        if (enabled) {
                            if (on)
                                return mouseArea.containsMouse ? globStyle.accentLight : globStyle.accent
                            else
                                return mouseArea.containsMouse ? globStyle.foreground : globStyle.backgroundFaded
                        }
                        else
                            return on ? globStyle.accentFaded : globStyle.foregroundFaded
                    }
                    border.width: globStyle.thickness
                    border.color: mouseArea.pressed ? globStyle.background : color
                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true
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
