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

    ColumnLayout {
        anchors.fill: parent

        SwipeView {
            id: svPane
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
        Layout.fillHeight: false
        Layout.fillWidth: false
        anchors.fill: parent
        anchors.margins: Constants.Sizes.marginLarge
        currentIndex: 0

        Item {
            AListView {
                model: parameterDataModel
            }
        }

        Item {
            AParameterPanel {

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

}
