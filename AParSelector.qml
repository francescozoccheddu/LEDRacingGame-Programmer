import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "Constants.js" as Constants

ListView {

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
                    text: modelData.name
                    font.pointSize: Constants.Sizes.fontMedium
                }
                Text {
                    text: modelData.description
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

    onCurrentItemChanged: {
    }

    ScrollIndicator.vertical: AScrollIndicator {
    }

}
