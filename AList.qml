import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

ListView {
    id: root
    currentIndex: 0
    focus: true
    highlightFollowsCurrentItem: false
    signal beforeIndexChange()

    delegate: Component {
        AListDelegate {
            eeParameter: modelData
            width: root.width
            list: root
        }
    }

    function changeIndex(index) {
        beforeIndexChange()
        currentIndex = index
    }

    ScrollIndicator.vertical: ScrollIndicator {}

}
