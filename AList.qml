import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

ListView {

    currentIndex: 0
    focus: true
    highlightFollowsCurrentItem: false

    delegate: Component {
        AListDelegate {
            eeParameter: modelData
            height: 200
            width: parent.width
        }
    }

    onCurrentItemChanged: {

    }

    ScrollIndicator.vertical: ScrollIndicator {}

}
