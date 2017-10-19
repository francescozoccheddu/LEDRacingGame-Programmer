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
        }
    }

    Component {
        id: compReal
        ARealParameter {
            parameter: root.parameter.data
        }
    }

    Component {
        id: compSound
        ASoundParameter {
            parameter: root.parameter.data
        }
    }

    Component {
        id: compBitmap
        ABitMapParameter {
            parameter: root.parameter.data
        }
    }

    function chooseParameter() {
        switch (parameter.type) {
            case "int":
                return compInt
            case "real":
                return compReal
            case "sound":
                return compSound
            case "bitmap":
                return compBitmap
        }
    }

    ColumnLayout {
        anchors.fill: parent

        Loader {
            sourceComponent: chooseParameter()
        }

    }

    /*AActionRow {
        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
    }*/

}
