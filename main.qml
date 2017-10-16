import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import "Constants.js" as Const

ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    SwipeView {
        id: svPane
        currentIndex: 0

        Item {

        }

        Item {

        }

    }

    ADeviceBar {
        anchors.fill: parent
    }

}
