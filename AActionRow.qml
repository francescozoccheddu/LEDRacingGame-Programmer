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
        onClicked: root.restore()
        backgroundColor: globStyle.background
        foregroundColor: globStyle.accent
        text: qsTr("Restore")
    }

    AButton {
        id: btLoad
        enabled: serialIO.open && !serialTask.isBusy()
        onClicked: root.load()
        text: qsTr("Load")
        backgroundColor: globStyle.background
        foregroundColor: globStyle.accent
    }

    AButton {
        id: btStore
        enabled: serialIO.open && !serialTask.isBusy()
        text: qsTr("Store")
        onClicked: root.store()
        backgroundColor: globStyle.background
        foregroundColor: globStyle.accent
    }
}
