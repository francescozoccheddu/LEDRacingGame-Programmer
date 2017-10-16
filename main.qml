import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    SwipeView {
        id: swipeView
        anchors.fill: parent
        clip: true
        Layout.fillHeight: true
        Layout.fillWidth: true
        background: Rectangle {
            color: "light grey"
        }

        Item {
            ParameterList {
                anchors.fill: parent
            }
        }

        Item {
            ParameterPanel {
                anchors.fill: parent
            }
        }
    }
}
