import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

RowLayout {
    id: root
    property var eeParameter
    property var list
    property bool isCurrent: list.currentIndex === index

    Rectangle {
        Layout.preferredWidth: (isCurrent || mouseArea.containsMouse) ? 10 : 0
        color: isCurrent ? globStyle.accent : globStyle.foreground
        Layout.fillHeight: true
        Layout.fillWidth: false
        Layout.rightMargin: 10
        Behavior on Layout.preferredWidth {
            NumberAnimation { duration: 100 }
        }
    }

    ColumnLayout {
        id: colRoot

        RowLayout {
            Layout.preferredWidth: 65535
            Layout.fillWidth: true
            Layout.rightMargin: 20
            id: row

            ColumnLayout {
                id: colLabels
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                Layout.topMargin: 10
                Layout.bottomMargin: 10
                height: 20
                spacing: 0

                ALabel {
                    text: eeParameter.name
                    size: 1.5
                    color: isCurrent ? globStyle.accent : globStyle.foreground
                }

                ALabel {
                    id: description
                    text: eeParameter.description
                    size: 1
                    color: isCurrent ? globStyle.accent : globStyle.foreground
                    visible: list.currentIndex === index
                }
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                width: colLabels.width
                height: colLabels.height
                Layout.fillHeight: false
                Layout.fillWidth: true
                hoverEnabled: true
                onClicked: {
                    list.changeIndex(index)
                }
            }

            AActionRow {
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                visible: isCurrent
                onRestore: {
                    panel.restore()
                }
                onLoad: {
                    panel.load()
                }
                onStore: {
                    panel.store()
                }
            }

        }

        Connections {
            target: list
            onBeforeIndexChange: {
                if (isCurrent)
                    panel.backup()
            }
        }

        AParameterPanel {
            id: panel
            load: isCurrent
            visible: isCurrent
            Layout.preferredWidth: 65535
            Layout.fillWidth: true
            eeParameter: root.eeParameter
        }
    }

}
