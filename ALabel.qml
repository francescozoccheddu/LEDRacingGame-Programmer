import QtQuick 2.0
import QtQuick.Controls 2.2

Label {
    property real size: 1
    font.pointSize: size * globStyle.fontSize
    color: globStyle.foreground
}
