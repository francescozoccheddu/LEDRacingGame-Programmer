import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

RowLayout {
    id: root
    property var eeParameter
    property var list
    property bool isCurrent: list.currentIndex === index

    Rectangle {
        Layout.preferredWidth: (isCurrent || mouseArea.containsMouse) ? globStyle.size * 0.25 : 0
        color: isCurrent ? enabled? globStyle.accent : globStyle.accentFaded : globStyle.foreground
        Layout.fillHeight: true
        Layout.fillWidth: false
        Layout.rightMargin: globStyle.size * 0.25
        Behavior on Layout.preferredWidth {
            NumberAnimation { duration: 100 }
        }
    }

    ColumnLayout {
        id: colRoot
        Layout.bottomMargin: globStyle.size * 0.25
        Layout.rightMargin: isAndroid ? 0 : (globStyle.size * 0.2)
        RowLayout {
            Layout.preferredWidth: 65535
            Layout.fillWidth: true
            Layout.rightMargin: globStyle.size * 0.25
            id: row

            ColumnLayout {
                id: colLabels
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                Layout.topMargin: globStyle.size * 0.25
                Layout.bottomMargin: globStyle.size * 0.25
                spacing: 0

                ALabel {
                    text: eeParameter.name
                    size: 1.5
                    color: isCurrent ? enabled? globStyle.accent : globStyle.accentFaded : enabled?globStyle.foreground : globStyle.foregroundFaded
                }

                ALabel {
                    id: description
                    text: eeParameter.description
                    size: 1
                    color: enabled? globStyle.accent : globStyle.accentFaded
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
