import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "Constants.js" as Constants

ColumnLayout {
    property var parameter

    RowLayout {
        Layout.preferredWidth: 65535
        Layout.fillHeight: false
        Layout.fillWidth: true

        Column {

            Label {
                id: lbName
                text: parameter.name
            }

            Label {
                id: lbDescription
                text: parameter.description
            }
        }

        AButton {
            text: qsTr("Restore")
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
        }

    }

    Loader {
        Layout.preferredWidth: 65535
        Layout.preferredHeight: 65535
        Layout.fillHeight: true
        Layout.fillWidth: true
    }
}
