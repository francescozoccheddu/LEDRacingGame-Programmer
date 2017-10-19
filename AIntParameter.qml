import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

RowLayout {
    property var parameter;

    SpinBox {
        id: slider
        from: parameter.from
        to: parameter.to
        editable: true
    }

    Label {
        text: parameter.unit !== 'undefined' ? parameter.unit : ""
    }

    function getParameterValue() {
        return slider.value
    }

    function setParameterValue(parameterValue) {
        slider.value = parameterValue
    }

}
