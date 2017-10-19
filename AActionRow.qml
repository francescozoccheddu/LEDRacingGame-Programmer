import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

RowLayout {
    id: root
    signal restore()
    signal load()
    signal store()

    AButton {
        id: btRestore
        text: qsTr("Restore")
        onClicked: root.restore()
    }

    AButton {
        id: btLoad
        text: qsTr("Load")
        onClicked: root.load()
    }

    AButton {
        id: btStore
        text: qsTr("Store")
        onClicked: root.store()
    }
}
