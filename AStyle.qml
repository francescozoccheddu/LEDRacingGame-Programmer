import QtQuick 2.0

QtObject {
    property color background: "#222"
    property color backgroundFaded: Qt.lighter(background)
    property color backgroundDarker: Qt.darker(background)
    property color accent: "#F00"
    property color accentFaded: Qt.darker(accent)
    property color accentLight: Qt.lighter(accent)
    property color foreground: "#AAA"
    property color foregroundFaded: Qt.darker(foreground)
    property int fontSize: size * 0.25
    property int spacing: size * 0.3
    property real size: isAndroid ? 25 : 35
    property real radius: 4
    property real thickness: size * 0.03
}
