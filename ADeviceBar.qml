import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

RowLayout {
    id: rowRoot
        ComboBox {
            id: cbDevice
        }

        AButton {
            id: btRefresh
            text: qsTr("Refresh")
            onClicked: {
                serialIO.updatePortList()
                console.log(serialIO.portList)
            }
        }

}
