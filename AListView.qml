import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "Constants.js" as Constants

ListView {
    anchors.fill: parent
    spacing: Constants.Sizes.marginSmall
    currentIndex: 0
    focus: true

    delegate: Component {
        id: contactDelegate
        Item {
            height: Constants.Sizes.listItem
            width: 100
            Column {
                Text {
                    text: model.name
                    font.pointSize: Constants.Sizes.fontMedium
                }
                Text {
                    text: model.description
                    font.pointSize: Constants.Sizes.fontMedium
                }
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    currentIndex = index;
                }
            }
        }
    }

    highlight: Rectangle {
        color: Constants.Colors.back
    }

}
