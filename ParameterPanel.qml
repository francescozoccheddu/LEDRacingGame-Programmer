import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item {
    id: parameterPanel
    property alias name: labName.text
    property alias description: labDescr.text

    ColumnLayout {
        id: colRoot
        spacing: 10
        anchors.fill: parent
        anchors.margins: 10

        RowLayout {
            id: rowBar
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.preferredWidth: -1
            Layout.fillWidth: true

            Column {
                id: colInfo
                Layout.preferredWidth: 65535
                Layout.fillWidth: true

                Text {
                    id: labName
                    elide: Text.ElideRight
                    wrapMode: Text.NoWrap
                    font.weight: Font.Bold
                    font.pixelSize: 14
                    width: parent.width
                }

                Text {
                    id: labDescr
                    elide: Text.ElideRight
                    font.weight: Font.Light
                    wrapMode: Text.NoWrap
                    font.pixelSize: 10
                    width: parent.width
                }
            }

            RowLayout {
                id: rowActions
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter

                Button {
                    id: buttRestore
                    text: qsTr("Restore")
                    background.implicitHeight: 25
                    background.implicitWidth: 50
                }

                Button {
                    id: buttLoad
                    text: qsTr("Load")
                    background.implicitHeight: 25
                    background.implicitWidth: 50
                }

                Button {
                    id: buttStore
                    text: qsTr("Store")
                    background.implicitHeight: 25
                    background.implicitWidth: 50
                }
            }
        }

        ColumnLayout {
            id: colContent
            spacing: 0
            Layout.preferredHeight: 65535
            Layout.preferredWidth: 65535
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.fillHeight: true
            Layout.fillWidth: true

            TabBar {
                id: tabBar
                width: 150
                currentIndex: swipeView.currentIndex
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.minimumHeight: 20
                Layout.minimumWidth: 150
                Layout.fillHeight: false
                Layout.preferredHeight: 20
                Layout.preferredWidth: 150

                TabButton {
                    id: tabButtSpec
                    text: qsTr("Tab Button")
                    height: parent.height
                }

                TabButton {
                    id: tabButtMan
                    text: qsTr("Tab Button")
                    height: parent.height
                }
            }

            SwipeView {
                id: swipeView
                clip: true
                Layout.fillHeight: true
                Layout.fillWidth: true
                currentIndex: tabBar.currentIndex
                background: Rectangle {
                    color: "light grey"
                }

                Item {
                    id: pageSpec
                    Loader {
                        id: placeholder
                    }
                }

                Item {
                    ManualParameterPanel {

                    }
                }
            }
        }
    }
}
