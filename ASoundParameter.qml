import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "ByteList.js" as ByteList

ColumnLayout {
    id: root
    property var eeParameterData

    RowLayout {
        AIntParameter {
            id: ticks
            eeParameterData: root.eeParameterData.ticks
        }
    }

    Row {
        visible: ByteList.toInt(ticks.getParameterValue()) > 0

        GroupBox {
            title: qsTr("PWM")
            ColumnLayout {
                anchors.fill: parent
                Repeater {
                    id: repeaterPWM
                    model: ByteList.toInt(ticks.getParameterValue())
                    ARealParameter {
                        eeParameterData: root.eeParameterData.pwm
                    }
                }
            }
        }
        GroupBox {
            title: qsTr("Duration")
            ColumnLayout {
                anchors.fill: parent
                Repeater {
                    id: repeaterDuration
                    model: ByteList.toInt(ticks.getParameterValue())
                    ARealParameter {
                        eeParameterData: root.eeParameterData.duration
                    }
                }
            }
        }
    }

    function getParameterValue() {
        var tc = ByteList.toInt(ticks.getParameterValue())
        var vals = []
        for (var t = 0; t < tc; t++) {
            var valsPWM = repeaterPWM.itemAt(t).getParameterValue()
            vals.push(ByteList.zeroPad(valsPWM, 2))
            var valsDuration = repeaterDuration.itemAt(t).getParameterValue()
            vals.push(ByteList.zeroPad(valsDuration, 2))
        }
        return vals
    }

    function setParameterValue(vals) {
        var tc = 0
        while (tc * 4 < vals.length && ByteList.toInt(vals.slice(tc * 4 + 2, tc * 4 + 4)) !== 0)
            tc++
        ticks.setParameterValue(ByteList.fromInt(tc))
        for (var t = 0; t < tc; t++) {
            repeaterPWM.itemAt(t).setParameterValue(vals.slice(t * 4, t * 4 + 2))
            repeaterDuration.itemAt(t).setParameterValue(vals.slice(t * 4 + 2, t * 4 + 4))
        }
    }

}

