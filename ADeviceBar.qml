import QtQuick 2.0
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
        color: globStyle.accentLight
        height: parent.height
        width: parent.width * (serialTask.isBusy() ? serialTask.getProgress() : 1)
        opacity: serialTask.isBusy() ? 1 : 0

        Behavior on opacity {
            NumberAnimation { duration: 200 }
        }
    }

    ColumnLayout {
        id: column

        RowLayout {
            Layout.margins: globStyle.size * 0.3

            ComboBox {
                id: cbDevice
                enabled: !serialIO.open
                model: {
                    var list = serialIO.portList
                    if (list.length === 0)
                        return ["No port"]
                    return list
                }

                property color accentColor: {
                    if (enabled) {
                        if (pressed)
                            return globStyle.accent
                        else
                            return globStyle.background
                    }
                    else
                        return globStyle.backgroundFaded
                }
                Component.onCompleted: serialIO.refreshPortList()

                delegate: Component {
                    Item {
                        height: cbDevice.height
                        width: cbDevice.width

                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                cbDevice.currentIndex = index
                                cbDevice.popup.close()
                            }
                        }

                        Rectangle {
                            height: parent.height - globStyle.thickness * 2
                            width: parent.width - globStyle.thickness * 2
                            x: globStyle.thickness
                            y: globStyle.thickness
                            color: {
                                if (mouseArea.pressed)
                                    return globStyle.accent
                                else
                                    return globStyle.backgroundFaded
                            }
                            visible: mouseArea.containsMouse
                        }

                        ALabel {
                            height: cbDevice.height
                            width: cbDevice.width
                            leftPadding: 20
                            rightPadding: 20
                            text: modelData
                            size: 1
                            color: {
                                if (mouseArea.pressed)
                                    return globStyle.background
                                else if (cbDevice.highlightedIndex === index)
                                    return globStyle.accent
                                else
                                    return globStyle.foreground
                            }
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                            elide: Label.ElideRight
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
                        context.fillStyle = cbDevice.accentColor;
                        context.fill();
                    }
                }

                contentItem: ALabel {
                    leftPadding: 20
                    rightPadding: cbDevice.indicator.width + cbDevice.spacing
                    visible: !cbDevice.popup.visible
                    text: cbDevice.displayText
                    color: cbDevice.accentColor
                    horizontalAlignment: Label.AlignLeft
                    verticalAlignment: Label.AlignVCenter
                    elide: Label.ElideRight
                }

                background: Rectangle {
                    visible: !cbDevice.popup.visible
                    implicitWidth: globStyle.size * 3
                    implicitHeight: globStyle.size
                    color: {
                        if (cbDevice.pressed)
                            return globStyle.background
                        else {
                            if (cbDevice.hovered)
                                return globStyle.accentLight
                            else
                                return "transparent"
                        }
                    }
                    border.color: cbDevice.accentColor
                    border.width: globStyle.thickness
                }

                /*popup: Popup {
                    y: 0
                    width: cbDevice.width
                    implicitHeight: contentItem.implicitHeight
                    onOpened: serialIO.refreshPortList()
                    padding: 0
                    contentItem: ListView {
                        clip: true
                        implicitHeight: contentHeight
                        model: cbDevice.popup.visible ? cbDevice.delegateModel : []
                        currentIndex: cbDevice.highlightedIndex

                        ScrollIndicator.vertical: ScrollIndicator { }
                    }

                    background: Rectangle {
                        border.color: globStyle.accent
                        border.width: globStyle.thickness
                        color: globStyle.background
                    }
                }*/
            }
            AButton {
                visible: !serialIO.open
                enabled: serialIO.portList.length > 0
                text: qsTr("Connect")
                backgroundColor: globStyle.accent
                foregroundColor: globStyle.background
                selectedBackgroundColor: globStyle.accentLight
                disabledForegroundColor: globStyle.backgroundFaded
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
                selectedBackgroundColor: globStyle.accentLight
                disabledForegroundColor: globStyle.backgroundFaded
                onClicked: {
                    serialIO.open = false
                }
            }
            Column {
                Layout.leftMargin: 5
                ALabel {
                    text: serialTask.describe()
                    color: globStyle.background
                    size: 1
                }

                ALabel {
                    text: serialIO.describe(cbDevice.currentText)
                    color: globStyle.background
                    size: 0.8
                }
            }

        }

    }
}
