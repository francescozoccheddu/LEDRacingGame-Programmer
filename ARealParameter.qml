import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

RowLayout {
    property var parData;

    Slider {
        id: slider
        from: parData.fromh
        to: parData.toh
        onValueChanged: {
            textField.text = value.toFixed(3)
        }
    }

    TextField {
        id: textField
        validator: DoubleValidator {
            bottom: parData.fromh
            top: parData.toh
            decimals: 3
            notation: DoubleValidator.StandardNotation
        }
        Keys.onReturnPressed: {
            var val = parseFloat(text)
            if (!isNaN(val))
                slider.value = val
        }
    }

}
