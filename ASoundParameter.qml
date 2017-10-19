import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

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
        visible: ticks.getParameterValue() > 0

        GroupBox {
            title: qsTr("PWM")
            ColumnLayout {
                anchors.fill: parent
                Repeater {
                    model: ticks.getParameterValue()
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
                    model: ticks.getParameterValue()
                    ARealParameter {
                        eeParameterData: root.eeParameterData.duration
                    }
                }
            }
        }
    }

}

