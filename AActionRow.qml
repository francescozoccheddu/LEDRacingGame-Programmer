import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

RowLayout {
    id: root
    signal restoreParameter()
    signal loadParameter()
    signal storeParameter()

    AButton {
        id: btRestore
        onClicked: root.restoreParameter()
        backgroundColor: globStyle.background
        foregroundColor: globStyle.accent
        selectedBackgroundColor: globStyle.backgroundFaded
        disabledForegroundColor: globStyle.accentFaded
        text: "Restore"
    }

    AButton {
        id: btLoad
        enabled: serialIO.open && !serialTask.isBusy()
        onClicked: root.loadParameter()
        text: "Load"
        backgroundColor: globStyle.background
        foregroundColor: globStyle.accent
        selectedBackgroundColor: globStyle.backgroundFaded
        disabledForegroundColor: globStyle.accentFaded
    }

    AButton {
        id: btStore
        enabled: serialIO.open && !serialTask.isBusy()
        text: "Store"
        onClicked: root.storeParameter()
        backgroundColor: globStyle.background
        foregroundColor: globStyle.accent
        selectedBackgroundColor: globStyle.backgroundFaded
        disabledForegroundColor: globStyle.accentFaded
    }
}
