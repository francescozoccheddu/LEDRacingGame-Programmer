import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

ColumnLayout {
    id: root
    property var eeParameter
    property var list

    RowLayout {
        Layout.preferredWidth: 65535
        Layout.fillWidth: true
        id: row
        ColumnLayout {
            id: colLabels
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            Layout.topMargin: 10
            Layout.bottomMargin: 10
            height: 20
            spacing: 0

            Label {
                text: eeParameter.name
                font.pointSize: 16
                PropertyAnimation on y { duration: 1000 }
            }

            Label {
                id: description
                text: eeParameter.description
                visible: list.currentIndex === index
            }
        }

        MouseArea {
            anchors.fill: parent
            width: colLabels.width
            height: colLabels.height
            Layout.fillHeight: false
            Layout.fillWidth: true
            onClicked: {
                list.currentIndex = index
            }
        }

        AActionRow {
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            visible: list.currentIndex === index
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
        load: list.currentIndex === index
        visible: list.currentIndex === index
        id: panel
        enabled: !serialTask.isBusy()
        Layout.preferredWidth: 65535
        Layout.fillWidth: true
        eeParameter: root.eeParameter
    }
}
