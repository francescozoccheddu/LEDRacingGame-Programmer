import QtQuick 2.0
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

    RowLayout {
        visible: ByteList.toInt(ticks.getParameterValue()) > 0

        ColumnLayout {
            Repeater {
                id: repeaterPWM
                model: ByteList.toInt(ticks.getParameterValue())
                ARealParameter {
                    eeParameterData: root.eeParameterData.pwm
                }
            }
        }
        ColumnLayout {
            Repeater {
                id: repeaterDuration
                model: ByteList.toInt(ticks.getParameterValue())
                ARealParameter {
                    eeParameterData: root.eeParameterData.duration
                }
            }
        }
    }

    function getParameterValue() {
        var tc = ByteList.toInt(ticks.getParameterValue())
        var vals = []
        for (var t = 0; t < tc; t++) {
            var valsPWM = repeaterPWM.itemAt(t).getParameterValue()
            vals = vals.concat(ByteList.zeroPad(valsPWM, 2))
            var valsDuration = repeaterDuration.itemAt(t).getParameterValue()
            vals = vals.concat(ByteList.zeroPad(valsDuration, 2))
        }
        vals = vals.concat([0,0,0,0])
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

