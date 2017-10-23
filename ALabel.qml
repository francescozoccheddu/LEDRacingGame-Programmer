import QtQuick 2.9
import QtQuick.Controls 2.2

Label {
    property real size: 1
    font.pointSize: size * globStyle.fontSize
    color: globStyle.foreground
    opacity: enabled ? 1 : globStyle.disabledOpacity
}
