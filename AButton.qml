import QtQuick 2.9
import QtQuick.Controls 2.2

Button {

    property color foregroundColor
    property color backgroundColor
    property color selectedBackgroundColor: Qt.lighter(backgroundColor)
    property color disabledForegroundColor: Qt.darker(foregroundColor)

    id: button

    background: Rectangle {
        implicitWidth: globStyle.size * 2
        implicitHeight: globStyle.size
        color: {
            if (button.down)
                return foregroundColor
            else {
                if (button.hovered)
                    return selectedBackgroundColor
                else
                    return backgroundColor
            }
        }
        border.color: button.down ? backgroundColor : foregroundColor
        border.width: globStyle.thickness
    }

    contentItem: Text {
        text: button.text
        color: button.down ? backgroundColor : foregroundColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }
}
