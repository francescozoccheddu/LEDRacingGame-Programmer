import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "ByteList.js" as ByteList

RowLayout {
    id: root
    property var eeParameter

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

    ColumnLayout {
        anchors.fill: parent

        Loader {
            id: loader
            source: getParameterQML(eeParameter.type)

            onLoaded: {
                item.eeParameterData = eeParameter.data
            }
        }

    }

    AActionRow {
        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
        onRestore: {
            loader.item.setParameterValue(eeParameter.defvalue)
        }
        onLoad: {
            serialTask.read(eeParameter.address, eeParameter.size, loader.item.setParameterValue)
        }
        onStore: {
            var vals = loader.item.getParameterValue()
            serialTask.write(eeParameter.address, ByteList.zeroPad(vals, eeParameter.size))
        }
    }

}
