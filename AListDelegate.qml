import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

ColumnLayout {
    id: root
    property var parameter

    RowLayout {
        Layout.preferredWidth: 65535
        Layout.fillWidth: true
        ColumnLayout {
            Text {
                text: modelData.name
            }
            Text {
                text: modelData.description
            }
        }
    }
    AParameterPanel {
        Layout.preferredHeight: 65535
        Layout.fillHeight: true
        Layout.preferredWidth: 65535
        Layout.fillWidth: true
        parameter: root.parameter
    }
}
