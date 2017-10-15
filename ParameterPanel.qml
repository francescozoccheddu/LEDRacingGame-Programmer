import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item {
    id: parameterPanel

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
                    text: qsTr("Name")
                    elide: Text.ElideRight
                    wrapMode: Text.NoWrap
                    font.weight: Font.Bold
                    font.pixelSize: 16
                    width: parent.width
                }

                Text {
                    id: labDescr
                    text: qsTr("Very very long description..")
                    elide: Text.ElideRight
                    font.weight: Font.Light
                    wrapMode: Text.NoWrap
                    font.pixelSize: 8
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
                    id: tabButton
                    text: qsTr("Tab Button")
                    height: parent.height
                }

                TabButton {
                    id: tabButton1
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
                    color: "red"
                }

                Item {
                    Loader {
                        id: placeholder
                    }
                }

                Item {
                    ColumnLayout {
                        anchors.fill: parent

                        Text {
                            id: text1
                            text: qsTr("Text")
                            font.pixelSize: 12
                        }

                    }
                }

            }



        }
    }
}
