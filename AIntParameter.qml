import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "ByteList.js" as ByteList

RowLayout {
    property var eeParameterData;
    RowLayout {

        SpinBox {
            id: spinbox
            from: eeParameterData.from
            to: eeParameterData.to
            editable: true

            contentItem: TextField {
                z: -2
                text: spinbox.textFromValue(spinbox.value, spinbox.locale)
                color: {
                    if (enabled) {
                        if (spinbox.contentItem.activeFocus)
                            return globStyle.background
                        else
                            return globStyle.accent
                    }
                    else
                        return globStyle.accentFaded
                }
                font.pointSize: globStyle.fontSize
                selectionColor: globStyle.accentLight
                selectedTextColor: globStyle.background
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                readOnly: !spinbox.editable
                validator: spinbox.validator
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                background: Item {}

                Keys.onReturnPressed: {
                    serialTask.forceActiveFocus()
                }
            }

            up.indicator: Rectangle {
                x: spinbox.mirrored ? 0 : parent.width - width
                height: parent.height
                implicitWidth: globStyle.size
                implicitHeight: globStyle.size
                color: {
                    if (spinbox.up.pressed)
                        return globStyle.accent
                    else if (spinbox.up.hovered)
                        return globStyle.backgroundFaded
                    else
                        return globStyle.background
                }
                border.color: {
                    if (enabled) {
                        if (spinbox.up.pressed)
                            return globStyle.background
                        else
                            return globStyle.accent
                    }
                    else
                        return globStyle.accentFaded
                }
                border.width: globStyle.thickness

                Text {
                    text: "+"
                    font.pixelSize: globStyle.fontSize * 2
                    color: parent.border.color
                    anchors.fill: parent
                    fontSizeMode: Text.Fit
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            down.indicator: Rectangle {
                x: spinbox.mirrored ? parent.width - width : 0
                height: parent.height
                implicitWidth: globStyle.size
                implicitHeight: globStyle.size
                color: {
                    if (spinbox.down.pressed)
                        return globStyle.accent
                    else if (spinbox.down.hovered)
                        return globStyle.backgroundFaded
                    else
                        return globStyle.background
                }
                border.color: {
                    if (enabled) {
                        if (spinbox.down.pressed)
                            return globStyle.background
                        else
                            return globStyle.accent
                    }
                    else
                        return globStyle.accentFaded
                }
                border.width: globStyle.thickness

                Text {
                    text: "-"
                    font.pixelSize: globStyle.fontSize * 2
                    color: parent.border.color
                    anchors.fill: parent
                    fontSizeMode: Text.Fit
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            background: Rectangle {
                z: -4
                implicitWidth: globStyle.size * 3.5
                color: {
                    if (spinbox.contentItem.activeFocus)
                        return globStyle.accent
                    else if (spinbox.contentItem.hovered)
                        return globStyle.backgroundFaded
                    else
                        return "transparent"
                }
                border.color: {
                    if (spinbox.contentItem.enabled) {
                        if (spinbox.contentItem.activeFocus)
                            return globStyle.background
                        else
                            return globStyle.accent
                    }
                    else
                        return globStyle.accentFaded
                }
                border.width: globStyle.thickness
            }
        }

        ALabel {
            text: typeof eeParameterData.unit !== 'undefined' ? eeParameterData.unit : ""
            color: enabled ? globStyle.accent : globStyle.accentFaded
        }

    }

    function getParameterValue() {
        return ByteList.fromInt(spinbox.value)
    }

    function setParameterValue(vals) {
        spinbox.value = ByteList.toInt(vals)
    }
}
