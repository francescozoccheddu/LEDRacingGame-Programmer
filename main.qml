import QtQuick 2.0
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
            Layout.topMargin: globStyle.size * 0.25
            Layout.rightMargin: 0
            Layout.bottomMargin: globStyle.size * 0.25
        }

        ADeviceBar {
            id: deviceBar
            Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
            Layout.fillHeight: false
            Layout.fillWidth: true
            Layout.preferredWidth: 65535
        }
    }

    Popup {
        id: serialError
        modal: true
        x: (applicationWindow.width - width) /2
        y: (applicationWindow.height - height) / 2
        closePolicy: Popup.NoAutoClose
        background: Rectangle {
            color: globStyle.background
            border.color: globStyle.accent
            border.width: globStyle.thickness
        }

        contentItem: ColumnLayout{
            ALabel {
                id: label
                color: globStyle.accent
                size: 1.25
            }
            ALabel {
                id: labelExt
                color: globStyle.accent
            }
            AButton {
                text: "Ignore"
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                backgroundColor: globStyle.background
                foregroundColor: globStyle.accent
                selectedBackgroundColor: globStyle.backgroundFaded
                disabledForegroundColor: globStyle.accentFaded
                onClicked: {
                    serialError.close()
                }
            }
        }

        function error(message, messageExt) {
            label.text = message
            labelExt.text = typeof messageExt === "undefined" ? "" : messageExt
            serialError.open()
        }
    }

    ALogic {
        id: serialTask
    }

    AStyle {
        id: globStyle
    }

}
