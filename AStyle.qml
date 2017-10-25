import QtQuick 2.0

QtObject {
    property color background: "#222"
    property color backgroundFaded: Qt.lighter(background)
    property color accent: "#F00"
    property color accentFaded: Qt.darker(accent)
    property color accentLight: Qt.lighter(accent)
    property color foreground: "#AAA"
    property color foregroundFaded: Qt.darker(foreground)
    property int fontSize: size * 0.25
    property real size: isAndroid ? 25 : 35
    property real thickness: size * 0.03
}
