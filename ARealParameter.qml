import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

RowLayout {
    property var eeParameterData;

    Slider {
        id: slider
        from: eeParameterData.fromh
        to: eeParameterData.toh
        onValueChanged: {
            textField.text = value.toFixed(3)
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

    Label {
        text: eeParameterData.unit !== 'undefined' ? eeParameterData.unit : ""
    }

    function getParameterValue() {
        var rangeh = eeParameterData.toh - eeParameterData.fromh
        var rangeb = eeParameterData.tob - eeParameterData.fromb
        return (slider.value-eeParameterData.fromh) * rangeb / rangeh + eeParameterData.fromb
    }

    function setParameterValue(parameterValue) {
        var rangeh = eeParameterData.toh - eeParameterData.fromh
        var rangeb = eeParameterData.tob - eeParameterData.fromb
        slider.value = (parameterValue - eeParameterData.fromb) * rangeh / rangeb + eeParameterData.fromh
    }

}
