import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

ColumnLayout {
    id: root
    property var eeParameter
    height: row.height + panel.height + spacing * 2

    RowLayout {
        id: row
        Layout.preferredWidth: 65535
        Layout.fillWidth: true
        ColumnLayout {
            Label {
                text: eeParameter.name
            }
            Label {
                text: typeof eeParameter.description == "undefined" ? "" : eeParameter.description
            }
        }

        AActionRow {
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
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
        enabled: !serialTask.isBusy()
        Layout.preferredWidth: 65535
        Layout.fillWidth: true
        eeParameter: root.eeParameter
    }
}
