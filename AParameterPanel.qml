import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "ByteList.js" as ByteList

RowLayout {
    id: root
    property var eeParameter
    property alias load: loader.active
    property var loaderValue: eeParameter.defvalue

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

    Component {
        id: parInt
        AIntParameter {
            eeParameterData: eeParameter.data
            Component.onCompleted: {
                setParameterValue(loaderValue)
            }
            Component.onDestruction: {
                loaderValue = getParameterValue()
            }
        }
    }
    Component {
        id: parReal
        ARealParameter {
            eeParameterData: eeParameter.data
            Component.onCompleted: {
                setParameterValue(loaderValue)
            }
            Component.onDestruction: {
                loaderValue = getParameterValue()
            }
        }
    }
    Component {
        id: parSound
        ASoundParameter {
            eeParameterData: eeParameter.data
            Component.onCompleted: {
                setParameterValue(loaderValue)
            }
            Component.onDestruction: {
                loaderValue = getParameterValue()
            }
        }
    }

    Component {
        id: parBitmap
        ABitmapParameter {
            eeParameterData: eeParameter.data
            Component.onCompleted: {
                setParameterValue(loaderValue)
            }
            Component.onDestruction: {
                loaderValue = getParameterValue()
            }
        }
    }

    function getParameterQML(type) {
        switch (type) {
            case "int":
                return parInt
            case "real":
                return parReal
            case "sound":
                return parSound
            case "bitmap":
                return parBitmap
        }
    }

    ColumnLayout {
        anchors.fill: parent

        Loader {
            id: loader
            sourceComponent: getParameterQML(eeParameter.type)
            Layout.preferredWidth: 65535
            Layout.fillWidth: true
            asynchronous: false

        }

    }

}
