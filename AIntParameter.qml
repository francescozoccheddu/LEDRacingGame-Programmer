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
