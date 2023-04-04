import QtQuick 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import Qt5Compat.GraphicalEffects
import QtQuick.Controls.Material 2.3

import Themes 0.1

Rectangle {
    id: background
    color: ColorThemes.pageBackgroundColor
    radius: 10

    clip: true

    GridView {
        id: pluginsGridView

        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 5
        anchors.topMargin: 10
        anchors.bottomMargin: 10

        readonly property int defaultCellWidth: 300
        readonly property int defaultCellHeight: 275

        cellWidth: Math.floor(width / Math.floor(width / defaultCellWidth))
        cellHeight: Math.floor((cellWidth / defaultCellWidth) * defaultCellHeight)

        onWidthChanged: {
            cellWidth: Math.floor(width / Math.floor(width / defaultCellWidth))
            cellHeight: Math.floor((cellWidth / defaultCellWidth) * defaultCellHeight)
        }

        ScrollBar.vertical: ScrollBar {
            id: vbar

            width: 12

            topPadding: width + 10
            bottomPadding: width + 10

            contentItem: Rectangle {
                color: "#aaa"
                radius: 10
            }

            background: Rectangle {
                color: "#f3f3f3"
                radius: 10
            }

            Image {
                source: 'qrc:/up_arrow.svg'
                sourceSize: Qt.size(parent.width - 4, parent.width)

                anchors.top: parent.top
                anchors.topMargin: 5
                anchors.horizontalCenter: parent.horizontalCenter

                MouseArea {
                    id: upButton
                    anchors.fill: parent

                    SmoothedAnimation {
                        target: pluginsGridView
                        property: "contentY"
                        running: upButton.pressed
                        velocity: 1000
                        to: 0
                    }

                    onReleased: {
                        if (!pluginsGridView.atYBeginning)
                            pluginsGridView.flick(0, 1000)
                    }
                }
            }

            Image {
                source: 'qrc:/down_arrow.svg'
                sourceSize: Qt.size(parent.width - 4, parent.width)

                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5
                anchors.horizontalCenter: parent.horizontalCenter

                MouseArea {
                    id: downButton
                    anchors.fill: parent

                    SmoothedAnimation {
                        target: pluginsGridView
                        property: "contentY"
                        running: downButton.pressed
                        to: pluginsGridView.contentHeight - pluginsGridView.height
                        velocity: 1000
                    }

                    onReleased: {
                        if (!pluginsGridView.atYEnd)
                            pluginsGridView.flick(0, -1000)
                    }
                }
            }
        }        

       /* model: ListModel {
            id: pluginsModel

            ListElement {
                title: "Custom Context Menu Context Menu"
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque quis auctor magna.Fusce congue finibus enim, a dictum justo consectetur sit amet. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut sit amet lacus auctor turpis scelerisque fermentum quis a nisi. Duis vulputate ullamcorper ex, a rhoncus lacus ullamcorper euismod. Pellentesque et neque at"
                pluginPreviewSource: "qrc:/plugin1.png"
            }
            ListElement {
                title: "TaskBar location"
                description: "Lorem ipsum dolor sit amet"
                pluginPreviewSource: "qrc:/plugin1.png"
            }
            ListElement {
                title: "Custom Context Menu"
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque quis auctor magna.Fusce congue finibus enim, a dictum justo consectetur sit amet. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut sit amet lacus auctor turpis scelerisque fermentum quis a nisi. Duis vulputate ullamcorper ex, a rhoncus lacus ullamcorper euismod. Pellentesque et neque at"
                pluginPreviewSource: "qrc:/plugin1.png"
            }
        }*/

        model: plugins

        delegate: Component {
            Rectangle {
                id: pluginDelegate

                width: pluginsGridView.cellWidth - 15
                height: pluginsGridView.cellHeight - 15

                radius: 10
                clip: true

                color: ColorThemes.delegateColor

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 10

                    spacing: 5

                    RowLayout {
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        Text {
                            id: pluginTitle
                            text: name//title
                            font.pointSize: 12
                            font.bold: true
                            color: "#fff"
                            verticalAlignment: Text.AlignVCenter
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            elide: Text.ElideRight
                        }

                        Button {
                            text: qsTr("Получить сейчас")

                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            onClicked: {
                                pluginPage.pluginPath = settingsPath
                                stackLayout.currentIndex = 1
                            }
                        }
                    }

                    Text {
                        id: pluginDescription
                        text: description
                        font.pointSize: 10
                        color: "#fff"
                        Layout.fillWidth: true
                        Layout.preferredHeight: description_metrics.tightBoundingRect.height * 3
                        wrapMode: Text.WordWrap
                        elide: Text.ElideRight
                    }

                    TextMetrics {
                        id:     description_metrics
                        font:   pluginDescription.font
                        text:   pluginDescription.text
                    }

                    Image {
                        id: pluginPreview

                        source: imgPath

                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        property bool rounded: true
                        property bool adapt: true

                        layer.enabled: true
                        layer.effect: OpacityMask {
                            maskSource: Item {
                                width: pluginPreview.width
                                height: pluginPreview.height
                                Rectangle {
                                    anchors.centerIn: parent
                                    width: pluginPreview.adapt ? pluginPreview.width : Math.min(pluginPreview.width, pluginPreview.height)
                                    height: pluginPreview.adapt ? pluginPreview.height : width
                                    radius: 10
                                }
                            }
                        }
                    }
                }
            }
        }

        focus: true
    }
}
