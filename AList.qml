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
            enabled: !serialTask.isBusy()
        }
    }

    function changeIndex(index) {
        currentIndex = index
    }

    ScrollBar.vertical: ScrollBar {
        id: control
        visible: !isAndroid
        contentItem: Rectangle {
            implicitWidth: globStyle.size * 0.2
            implicitHeight: globStyle.size * 2
            color: {
                if (control.pressed)
                    return globStyle.accent
                else {
                    if (control.hovered)
                        return globStyle.foreground
                    else
                        return globStyle.foregroundFaded
                }
            }
        }
    }

}
