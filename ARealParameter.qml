import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

RowLayout {
    property var parameter;

    Slider {
        id: slider
        from: parameter.fromh
        to: parameter.toh
        onValueChanged: {
            textField.text = value.toFixed(3)
        }
    }

    TextField {
        id: textField
        validator: DoubleValidator {
            bottom: parameter.fromh
            top: parameter.toh
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
        text: parameter.unit !== 'undefined' ? parameter.unit : ""
    }

    function getParameterValue() {

    }

    function setParameterValue(parameterValue) {

    }

}
