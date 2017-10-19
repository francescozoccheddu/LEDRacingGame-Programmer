import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

RowLayout {
    property var eeParameterData;

    SpinBox {
        id: slider
        from: eeParameterData.from
        to: eeParameterData.to
        editable: true
    }

    Label {
        text: eeParameterData.unit !== 'undefined' ? eeParameterData.unit : ""
    }

    function getParameterValue() {
        return slider.value
    }

    function setParameterValue(parameterValue) {
        slider.value = parameterValue
    }

}
