import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

ListView {
    id: root
    currentIndex: 0
    focus: true
    highlightFollowsCurrentItem: false

    delegate: Component {
        AListDelegate {
            eeParameter: modelData
            Layout.preferredWidth: 65535
            Layout.fillWidth: true
            list: root
        }
    }

    Behavior on height {
        NumberAnimation { duration: 300; easing.type: Easing.OutBack }
    }
    onCurrentItemChanged: {
    }

    ScrollIndicator.vertical: ScrollIndicator {}

}
