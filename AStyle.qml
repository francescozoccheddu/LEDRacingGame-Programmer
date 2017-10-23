import QtQuick 2.0

QtObject {
    property color background: "#222"
    property color backgroundFaded: Qt.lighter(background)
    property color accent: "#0F0"
    property color accentFaded: Qt.darker(accent)
    property color foreground: "#AAA"
    property color foregroundFaded: Qt.darker(foreground)
    property int fontSize: size / 4
    property int spacing: 10
    property real size: 40
    property real radius: 4
    property real thickness: 2
}
