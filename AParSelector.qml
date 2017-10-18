import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

ListView {

    Component {
        id: parDelegate

        AListDelegate {
            parameter: modelData
            height: 200
            width: parent.width
        }

    }

    currentIndex: 0
    focus: true
    highlightFollowsCurrentItem: false
    delegate: parDelegate

    onCurrentItemChanged: {
    }

    ScrollIndicator.vertical: ScrollIndicator {
    }

}
