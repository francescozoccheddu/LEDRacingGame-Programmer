import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

RowLayout {
    id: rowRoot
        ComboBox {
            id: cbDevice
            enabled: !serialIO.open
            model: {
                var list = serialIO.portList
                if (list.length === 0)
                    list = ["No port"]
                return list
            }
            popup.onOpened: serialIO.refreshPortList()
            Component.onCompleted: serialIO.refreshPortList()
        }

        AButton {
            id: btConnect
            visible: !serialIO.open
            enabled: serialIO.portList.length > 0
            text: qsTr("Connect")
            onClicked: {
                serialIO.port = cbDevice.currentText
                serialIO.open = true
            }
        }

        AButton {
            id: btDisconnect
            visible: serialIO.open
            text: qsTr("Disconnect")
            onClicked: {
                serialIO.open = false
            }
        }
}
