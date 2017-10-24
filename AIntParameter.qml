import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "ByteList.js" as ByteList

RowLayout {
    property var eeParameterData;

    SpinBox {
        id: spinbox
        from: eeParameterData.from
        to: eeParameterData.to
        editable: true
        property color accentColor: {
            if (enabled)
                return globStyle.accent
            else
                return globStyle.accentFaded
        }

        contentItem: TextField {
            z: -2
            text: spinbox.textFromValue(spinbox.value, spinbox.locale)
            font: spinbox.font
            color: spinbox.accentColor
            selectionColor: globStyle.backgroundFaded
            selectedTextColor: globStyle.accent
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            readOnly: !spinbox.editable
            validator: spinbox.validator
            inputMethodHints: Qt.ImhFormattedNumbersOnly

            background: Item {

            }
        }

        up.indicator: Rectangle {
            x: spinbox.mirrored ? 0 : parent.width - width
            height: parent.height
            implicitWidth: 40
            implicitHeight: 40
            color: {
                if (spinbox.up.pressed)
                    return spinbox.accentColor
                else {
                    if (spinbox.up.hovered)
                        return globStyle.backgroundFaded
                    else
                        return globStyle.background
                }
            }
            border.color: spinbox.up.pressed ? globStyle.background : spinbox.accentColor
            border.width: globStyle.thickness

            Text {
                text: "+"
                font.pixelSize: globStyle.fontSize * 2
                color: spinbox.up.pressed ? globStyle.background : spinbox.accentColor
                anchors.fill: parent
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
        down.indicator: Rectangle {
            x: spinbox.mirrored ? parent.width - width : 0
            height: parent.height
            implicitWidth: 40
            implicitHeight: 40
            color: {
                if (spinbox.down.pressed)
                    return spinbox.accentColor
                else {
                    if (spinbox.down.hovered)
                        return globStyle.backgroundFaded
                    else
                        return globStyle.background
                }
            }
            border.color: spinbox.down.pressed ? globStyle.background : spinbox.accentColor
            border.width: globStyle.thickness

            Text {
                text: "-"
                font.pixelSize: globStyle.fontSize * 2
                color: spinbox.down.pressed ? globStyle.background : spinbox.accentColor
                anchors.fill: parent
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        background: Rectangle {
            z: -4
            implicitWidth: 140
            color: spinbox.contentItem.hovered ? globStyle.backgroundFaded : globStyle.background
            border.color: spinbox.accentColor
            border.width: globStyle.thickness
        }
    }

    ALabel {
        text: typeof eeParameterData.unit !== 'undefined' ? eeParameterData.unit : ""
    }

    function getParameterValue() {
        return ByteList.fromInt(spinbox.value)
    }

    function setParameterValue(vals) {
        spinbox.value = ByteList.toInt(vals)
    }

}
