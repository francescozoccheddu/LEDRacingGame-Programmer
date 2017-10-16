import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "Constants.js" as Constants

ListView {
    anchors.fill: parent
    spacing: Constants.Sizes.marginSmall
    currentIndex: 0
    focus: true
    highlightFollowsCurrentItem: false

    delegate: Component {
        id: contactDelegate
        Item {
            height: Constants.Sizes.listItem
            width: parent.width
            x: ListView.isCurrentItem ? 10 : 0
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

    highlight: Component {
        id: highlight
        Rectangle {
            width: parent.width;
            height: Constants.Sizes.listItem
            color: Constants.Colors.front
            y: currentItem.y
        }
    }

    ScrollIndicator.vertical: ScrollIndicator {
    }

}
