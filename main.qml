import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2

ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 640
    height: 480
    title: "Configuration tool"
    color: globStyle.background

    ColumnLayout {
        anchors.fill: parent

        AList {
            id: parSelector
            model: JSON.parse(fileIO.read(":/eeParameters.json"))
            Layout.preferredHeight: 65535
            Layout.preferredWidth: 65535
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.leftMargin: 0
            Layout.topMargin: 10
            Layout.rightMargin: 0
            Layout.bottomMargin: 10
        }

        ADeviceBar {
            id: deviceBar
            Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
            Layout.fillHeight: false
            Layout.fillWidth: true
            Layout.preferredWidth: 65535
        }
    }

    MessageDialog {
        id: serialError
        title: "Serial port error"
        icon: StandardIcon.Warning
        standardButtons: StandardButton.Ignore

        function error(message, messageExt) {
            text = message
            informativeText = typeof messageExt === "undefined" ? "" : messageExt
            visible = true
        }
    }

    ALogic {
        id: serialTask
    }

    AStyle {
        id: globStyle
    }

}
