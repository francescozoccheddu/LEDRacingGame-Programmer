import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "ByteList.js" as ByteList

RowLayout {
    property var eeParameterData;

    Slider {
        id: slider
        from: eeParameterData.fromh
        to: eeParameterData.toh
        onValueChanged: {
            textField.text = value.toFixed(3)
        }
        property color accentColor: {
            if (enabled)
                return globStyle.accent
            else
                return globStyle.accentFaded
        }

        background: Rectangle {
            x: slider.leftPadding
            y: slider.topPadding + slider.availableHeight / 2 - height / 2
            implicitWidth: 200
            implicitHeight: 4
            width: slider.availableWidth
            height: implicitHeight
            color: slider.accentColor

            Rectangle {
                width: slider.visualPosition * parent.width
                height: parent.height
                color: slider.accentColor
            }
        }

        handle: Rectangle {
            x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
            y: slider.topPadding + slider.availableHeight / 2 - height / 2
            implicitWidth: 26
            implicitHeight: 26
            radius: 13
            color:{
                if (slider.pressed)
                    return globStyle.accent
                else if (slider.hovered)
                    return globStyle.backgroundFaded
                else
                    return globStyle.background
            }
            border.color: slider.pressed ? globStyle.background : slider.accentColor
            border.width: globStyle.thickness
        }
    }

    TextField {
        id: textField
        validator: DoubleValidator {
            bottom: eeParameterData.fromh
            top: eeParameterData.toh
            decimals: 3
            notation: DoubleValidator.StandardNotation
        }
        Keys.onReturnPressed: {
            var val = parseFloat(text)
            if (!isNaN(val))
                slider.value = val
        }
    }

    ALabel {
        text: eeParameterData.unit !== 'undefined' ? eeParameterData.unit : ""
    }

    function getParameterValue() {
        var rangeh = eeParameterData.toh - eeParameterData.fromh
        var rangeb = eeParameterData.tob - eeParameterData.fromb
        var val = Math.round((slider.value-eeParameterData.fromh) * rangeb / rangeh + eeParameterData.fromb)
        return ByteList.fromInt(val)
    }

    function setParameterValue(vals) {
        var val = ByteList.toInt(vals)
        var rangeh = eeParameterData.toh - eeParameterData.fromh
        var rangeb = eeParameterData.tob - eeParameterData.fromb
        var sval = (val - eeParameterData.fromb) * rangeh / rangeb + eeParameterData.fromh
        slider.value = sval
        textField.text = sval.toFixed(3)
    }

}
