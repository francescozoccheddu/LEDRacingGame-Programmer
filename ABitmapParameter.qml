import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

ColumnLayout {
    property var eeParameterData
    Repeater {
        model: eeParameterData.count
        GridLayout {
            rows: eeParameterData.rows
            columns: eeParameterData.columns

            Repeater {
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
    }

    function setParameterValue(parameterValue) {

    }

}
