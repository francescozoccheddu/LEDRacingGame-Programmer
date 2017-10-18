import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "Constants.js" as Constants

ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    readonly property var parList: JSON.parse(fileIO.read("C:/Users/zocch/Desktop/test.json"))

    ColumnLayout {
        anchors.fill: parent

        RowLayout {
            Layout.preferredWidth: 65535
            Layout.fillHeight: true
            Layout.fillWidth: true

            AParSelector {
                id: parSelector
                model: parList
                width: 300
                Layout.fillHeight: true
            }

            AParameterPanel {
                id: aParameterPanel
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredWidth: 65535
                parameter: parList[parSelector.currentIndex]
            }
        }
    }

    ADeviceBar {
        id: deviceBar
        Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
        Layout.fillHeight: false
        Layout.fillWidth: true
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: Constants.Sizes.marginLarge
    }


}
