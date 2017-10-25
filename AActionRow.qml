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
        selectedBackgroundColor: globStyle.backgroundFaded
        disabledForegroundColor: globStyle.accentFaded
        text: "Restore"
    }

    AButton {
        id: btLoad
        enabled: serialIO.open && !serialTask.isBusy()
        onClicked: root.load()
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
        onClicked: root.store()
        backgroundColor: globStyle.background
        foregroundColor: globStyle.accent
        selectedBackgroundColor: globStyle.backgroundFaded
        disabledForegroundColor: globStyle.accentFaded
    }
}
