import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

RowLayout {
    property var parameter

    Component {
        id: compInt
        AIntParameter {
            parData: parameter
            visible: parameter.type === "int"
        }
    }

    Component {
        id: compReal
        ARealParameter {
            parData: parameter
            visible: parameter.type === "real"
        }
    }

    GroupBox {
        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
        title: parameter.unit

        ColumnLayout {
            anchors.fill: parent

            Loader {
                sourceComponent: {
                    switch (parameter.type) {
                    case "int":
                        return compInt
                    case "real":
                        return compReal
                    }
                }
            }

        }
    }

    AActionRow {
        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
    }

}
