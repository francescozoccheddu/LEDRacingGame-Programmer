import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2

ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    ColumnLayout {
        anchors.fill: parent

            AList {
                id: parSelector
                model: JSON.parse(fileIO.read("C:/Users/zocch/Desktop/test.json"))
                Layout.preferredHeight: 65535
                Layout.preferredWidth: 65535
                Layout.fillHeight: true
                Layout.fillWidth: true
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
        id: serialErrorDialog
        title: "Serial port error"
        icon: StandardIcon.Warning
        standardButtons: StandardButton.Ignore
    }

    Connections {
        target: serialIO
        onError: {
            serialErrorDialog.visible = true
            serialErrorDialog.text = "Error code " + code
            serialErrorDialog.informativeText = message
        }
    }

}
