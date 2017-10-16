import QtQuick 2.9

Item {

    ListModel {
        id: myModel
        ListElement {
            name: "dio"
        }
    }

    ListView {
        width: parent.width
        height: parent.height
        model: myModel
        delegate: Rectangle {
            height: 25
            width: 100
            color: "red"
            Text { text: name }
        }
        spacing: 4
    }
}
