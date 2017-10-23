import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "ByteList.js" as ByteList

RowLayout {
    id: root
    property var eeParameter

    function restore() {
        loader.item.setParameterValue(eeParameter.defvalue.slice())
    }

    function store() {
        var vals = loader.item.getParameterValue()
        serialTask.write(eeParameter.address, ByteList.zeroPad(vals, eeParameter.size))
    }

    function load() {
        serialTask.read(eeParameter.address, eeParameter.size, loader.item.setParameterValue)
    }

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
            Layout.preferredWidth: 65535
            Layout.fillWidth: true

            onLoaded: {
                item.eeParameterData = eeParameter.data
                restore()
            }
        }

    }

}
