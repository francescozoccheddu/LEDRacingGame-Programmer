import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

RowLayout {
    id: root
    property var onRestore
    property var onLoad
    property var onStore

    AButton {
        id: btRestore
        text: qsTr("Restore")
        onClicked: root.onRestore()
    }

    AButton {
        id: btLoad
        text: qsTr("Load")
        onClicked: root.onLoad()
    }

    AButton {
        id: btStore
        text: qsTr("Store")
        onClicked: root.onStore()
    }
}
