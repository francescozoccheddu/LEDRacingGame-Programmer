import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    readonly property var parList: JSON.parse(fileIO.read("C:/Users/zocch/Desktop/test.json"))

    ColumnLayout {
        anchors.fill: parent

            AParSelector {
                id: parSelector
                model: parList
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

}
