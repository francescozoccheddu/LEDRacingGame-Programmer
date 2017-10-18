import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

RowLayout {
    property var parData;

    SpinBox {
        id: slider
        from: parData.from
        to: parData.to
        editable: true
    }

}
