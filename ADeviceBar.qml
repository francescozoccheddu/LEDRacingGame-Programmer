import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item {
    height: column.height

    Rectangle {
        id: background
        color: globStyle.accent
        anchors.fill: parent
    }

    Rectangle {
        id: progress
        color: "red"
        height: parent.height
        width: parent.width * (serialTask.isBusy() ? serialTask.getProgress() : 1)
    }

    ColumnLayout {
        id: column

        RowLayout {
            Layout.margins: globStyle.spacing

            ComboBox {
                id: cbDevice
                enabled: !serialIO.open
                opacity: enabled ? 1 : globStyle.disabledOpacity
                model: {
                    var list = serialIO.portList
                    if (list.length === 0)
                        list = ["No port"]
                    return list
                }

                Component.onCompleted: serialIO.refreshPortList()

                delegate: Component {
                    Item {
                        height: cbDevice.height
                        width: cbDevice.width

                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            onClicked: {
                                cbDevice.currentIndex = index
                                cbDevice.popup.close()
                            }
                        }

                        Rectangle {
                            anchors.fill: parent
                            color: globStyle.accent
                            visible: mouseArea.pressed
                        }

                        Text {
                            height: cbDevice.height
                            width: cbDevice.width
                            leftPadding: 20
                            rightPadding: 20
                            text: modelData
                            font: cbDevice.font
                            color: {
                                if (mouseArea.pressed)
                                    return globStyle.background
                                else if (cbDevice.highlightedIndex === index)
                                    return globStyle.accent
                                else
                                    return globStyle.foreground
                            }
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            elide: Text.ElideRight
                        }
                    }
                }

                indicator: Canvas {
                    id: canvas
                    x: cbDevice.width - width - cbDevice.rightPadding
                    y: cbDevice.topPadding + (cbDevice.availableHeight - height) / 2
                    width: 12
                    height: 8
                    contextType: "2d"
                    visible: !cbDevice.popup.visible

                    Connections {
                        target: cbDevice
                        onPressedChanged: canvas.requestPaint()
                    }

                    onPaint: {
                        context.reset();
                        context.moveTo(0, height);
                        context.lineTo(width, height);
                        context.lineTo(width / 2, 0);
                        context.closePath();
                        context.fillStyle = cbDevice.pressed  ? globStyle.accent : globStyle.background;
                        context.fill();
                    }
                }

                contentItem: Text {
                    leftPadding: 20
                    rightPadding: cbDevice.indicator.width + cbDevice.spacing
                    visible: !cbDevice.popup.visible
                    text: cbDevice.displayText
                    font: cbDevice.font
                    color: cbDevice.pressed  ? globStyle.accent : globStyle.background
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                background: Rectangle {
                    visible: !cbDevice.popup.visible
                    implicitWidth: 120
                    implicitHeight: 40
                    color: cbDevice.pressed ? globStyle.background : globStyle.accent
                    border.color: cbDevice.pressed  ? globStyle.accent : globStyle.background
                    border.width: globStyle.thickness
                }

                popup: Popup {
                    width: cbDevice.width
                    implicitHeight: contentItem.implicitHeight
                    onOpened: serialIO.refreshPortList()
                    padding: 0
                    contentItem: ListView {
                        clip: true
                        implicitHeight: contentHeight
                        model: cbDevice.popup.visible ? cbDevice.delegateModel : null
                        currentIndex: cbDevice.highlightedIndex

                        ScrollIndicator.vertical: ScrollIndicator { }
                    }

                    background: Rectangle {
                        border.color: globStyle.accent
                        border.width: globStyle.thickness
                        color: globStyle.background
                    }
                }
            }

            AButton {
                visible: !serialIO.open
                enabled: serialIO.portList.length > 0
                text: qsTr("Connect")
                backgroundColor: globStyle.accent
                foregroundColor: globStyle.background
                onClicked: {
                    serialIO.port = cbDevice.currentText
                    serialIO.open = true
                }
            }

            AButton {
                visible: serialIO.open
                text: qsTr("Disconnect")
                backgroundColor: globStyle.accent
                foregroundColor: globStyle.background
                onClicked: {
                    serialIO.open = false
                }
            }
        }

    }
}
