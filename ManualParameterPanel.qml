import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item {
    id: root
    ColumnLayout {
        id: colRoot
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 10

        RowLayout {
            id: rowVal
            width: 100
            height: 100


            Text {
                id: labValHint
                text: "Write "
                font.pixelSize: 12
            }

            TextField {
                id: tfVal
                text: qsTr("Text Field")
                background.implicitHeight: 30

                function getFilteredText() {
                    return text;
                }

                function getHex() {
                    return getFilteredText();
                }
            }



            ComboBox {
                id: cbValBase
                model: ListModel {
                    id: cbItems
                    ListElement { text: "Hexadecimal" }
                    ListElement { text: "Decimal" }
                    ListElement { text: "Binary" }
                }
                background.implicitHeight: 20
                indicator.height: 20
                indicator.width: 30
            }

            ComboBox {
                id: cbValEnd
                enabled: cbValBase.currentIndex == 1
                model: ListModel {
                    id: cbItems1
                    ListElement { text: "Big-Endian" }
                    ListElement { text: "Little-Endian" }
                }
                background.implicitHeight: 20
                indicator.height: 20
                indicator.width: 30
            }
        }


        RowLayout {
            id: rowAddr
            width: 100
            height: 100

            Text {
                id: labAddrHintFrom
                text: qsTr("from byte offset ")
                font.pixelSize: 12
            }

            SpinBox {
                id: sbAddrFrom
                background.implicitWidth: 80
                background.implicitHeight: 20
                up.indicator.implicitHeight: 20
                up.indicator.implicitWidth: 20
                down.indicator.implicitHeight: 20
                down.indicator.implicitWidth: 20
            }

            Text {
                id: labAddrHintTo
                text: qsTr("to byte offset ")
                font.pixelSize: 12
            }

            SpinBox {
                id: sbAddrTo
                up.indicator.implicitHeight: 20
                down.indicator.implicitWidth: 20
                down.indicator.implicitHeight: 20
                background.implicitWidth: 80
                up.indicator.implicitWidth: 20
                background.implicitHeight: 20
            }


        }

        TextArea {
            id: taPrev
            text: qsTr("Text Area")
        }
    }
}

