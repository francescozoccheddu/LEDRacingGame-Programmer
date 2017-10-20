import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

RowLayout {
    id: rowRoot
        ComboBox {
            id: cbDevice
            model: serialIO.portList
            textRole: "name"
        }

        AButton {
            id: btRefresh
            text: qsTr("Refresh")
            onClicked: {
                serialIO.updatePortList()
                var list = serialIO.portList
                console.log(list)
                for (var p = 0; p < list.length; p++)
                    console.log(list[p].name)
            }
        }

}
