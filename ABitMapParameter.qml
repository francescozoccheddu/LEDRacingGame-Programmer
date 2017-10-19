import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

ColumnLayout {
    property var parameter
    Repeater {
        model: parameter.count
        GridLayout {
            rows: parameter.rows
            columns: parameter.columns

            Repeater {
                model: parameter.rows * parameter.columns
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
