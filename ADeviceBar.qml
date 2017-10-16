import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "Constants.js" as Constants

RowLayout {
    id: rowRoot
    anchors.margins: Constants.Sizes.marginLarge

    AButton {
        id: btBack
        text: qsTr("Back")
    }

    RowLayout {
        id: rowDevice
        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter

        RowLayout {
            id: rowParameter

            AButton {
                id: btLoad
                text: qsTr("Load")
            }

            AButton {
                id: btStore
                text: qsTr("Store")
            }
        }

        AComboBox {
            id: cbDevice
        }

        AButton {
            id: btRefresh
            text: qsTr("Refresh")
        }
    }
}
