import QtQuick 2.0
import QtQuick.Controls 2.2

Button {

    property color foregroundColor
    property color backgroundColor
    property color selectedBackgroundColor
    property color disabledForegroundColor

    property color accentColor: {
        if (enabled) {
            if (button.down)
                return backgroundColor
            else
                return foregroundColor
        }
        else
            return disabledForegroundColor
    }

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
                    return "transparent"
            }
        }
        border.color: accentColor
        border.width: globStyle.thickness
    }

    contentItem: ALabel {
        text: button.text
        color: accentColor
        horizontalAlignment: Label.AlignHCenter
        verticalAlignment: Label.AlignVCenter
        elide: Label.ElideRight
    }
}
