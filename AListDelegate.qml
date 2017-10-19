import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

ColumnLayout {
    id: root
    property var eeParameter

    RowLayout {
        Layout.preferredWidth: 65535
        Layout.fillWidth: true
        ColumnLayout {
            Label {
                text: eeParameter.name
            }
            Label {
                text: eeParameter.description
            }
        }
    }

    AParameterPanel {
        Layout.preferredHeight: 65535
        Layout.fillHeight: true
        Layout.preferredWidth: 65535
        Layout.fillWidth: true
        eeParameter: root.eeParameter
    }
}
