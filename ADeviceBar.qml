import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "Constants.js" as Constants

RowLayout {
    id: rowRoot

    AButton {
        id: btBack
        text: qsTr("Back")
        visible: svPane.currentIndex == 1
        onClicked: { svPane.currentIndex = 0}
    }

    RowLayout {
        id: rowDevice
        Layout.fillWidth: false
        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter

        AComboBox {
            id: cbDevice
        }

        AButton {
            id: btRefresh
            text: qsTr("Refresh")
        }
    }
}
