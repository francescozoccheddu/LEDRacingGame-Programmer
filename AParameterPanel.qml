import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

RowLayout {
    id: root
    property var parameter

    Component {
        id: compInt
        AIntParameter {
            parameter: root.parameter.data
            visible: root.parameter.type === "int"
        }
    }

    Component {
        id: compReal
        ARealParameter {
            parameter: root.parameter.data
            visible: root.parameter.type === "real"
        }
    }

    Component {
        id: compSound
        ASoundParameter {
            parameter: root.parameter.data
            visible: root.parameter.type === "sound"
        }
    }

    ColumnLayout {
        anchors.fill: parent

        Loader {
            sourceComponent: {
                switch (root.parameter.type) {
                case "int":
                    return compInt
                case "real":
                    return compReal
                case "sound":
                    return compSound
                }
            }
        }

    }

    /*AActionRow {
        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
    }*/

}
