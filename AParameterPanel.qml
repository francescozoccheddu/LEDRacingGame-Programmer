import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

RowLayout {
    id: root
    property var parameter

    function getParameterQML(type) {
        switch (type) {
            case "int":
                return "AIntParameter.qml"
            case "real":
                return "ARealParameter.qml"
            case "sound":
                return "ASoundParameter.qml"
            case "bitmap":
                return "ABitmapParameter.qml"
        }
    }

    function parameterStore() {
        var val = loader.item.getParameterValue()
        console.log(val)
    }

    function parameterLoad() {
        console.log("Load")
    }

    function parameterRestore() {
        console.log("Restore " )
    }

    ColumnLayout {
        anchors.fill: parent

        Loader {
            id: loader
            source: getParameterQML(parameter.type)

            onLoaded: {
                item.parameter = root.parameter.data
            }
        }

    }

    AActionRow {
        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
        onRestore: parameterRestore
        onLoad: parameterLoad
        onStore: parameterStore
    }

}
