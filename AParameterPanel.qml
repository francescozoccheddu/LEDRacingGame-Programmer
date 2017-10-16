import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "Constants.js" as Constants

Rectangle {
    id: rectangle
    anchors.fill: parent
    color: Constants.Colors.front

    RowLayout {
        anchors.right: parent.right
        anchors.rightMargin: 640
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0

        ColumnLayout {
            id: columnLayout
            width: 100
            height: 100

            Label {
                id: label
                text: qsTr("Name")
            }

            Label {
                id: label1
                text: qsTr("Description")
            }
        }

    }
}
