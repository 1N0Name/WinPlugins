import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.5
import Qt5Compat.GraphicalEffects
import Themes 0.1

import "../controls/"

Rectangle {
    id: background
    color: ColorThemes.layer_02
    radius: 10

    /* -------------------- Internal properties / functions. -------------------- */
    QtObject {
        id: internal

        function toggleScrollBar() {
            if(vbar.hovered) {
//                vbarIndicator.width     = vbar.width - vbar.contentItemOffset
                vbarBG.opacity          = 1
                vbarUpArrow.opacity     = 1
                vbarDownArrow.opacity   = 1
            } else if (!vbar.pressed) {
//                vbarIndicator.width     = vbar.width / 2
                vbarBG.opacity          = 0
                vbarUpArrow.opacity     = 0
                vbarDownArrow.opacity   = 0
            }
        }
    }
    /* -------------------------------------------------------------------------- */

    Rectangle {
        id:controlPanel
        color: ColorThemes.transparent
        height: 40

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        RowLayout {
            spacing: 10

            anchors.fill: parent
            anchors.topMargin: 10
            anchors.leftMargin: pluginsGridView.anchors.leftMargin
            anchors.rightMargin: vbar.width + pluginsGridView.anchors.rightMargin


            SearchBar {
                id: searchField

                Layout.preferredWidth: 320
                Layout.fillHeight: true
            }

            Text {
                text: qsTr("Категория: ")
                color: ColorThemes.highEmphasisText
                font.pointSize: 12
            }

            CustomComboBox {
                Layout.fillHeight: true
                model: ListModel {
                    id: categoryModel
                    ListElement { text: "Контекстное меню" }
                    ListElement { text: "Таскбар" }
                }
            }

            Text {
                text: qsTr("Стоимость: ")
                color: ColorThemes.highEmphasisText
                font.pointSize: 12
            }

            CustomComboBox {
                Layout.fillHeight: true
                model: ListModel {
                    id: priceModel
                    ListElement { text: "Бесплатные" }
                    ListElement { text: "Все" }
                }
            }

           Item {
               Layout.fillWidth: true
           }
        }
    }

    GridView {
        id: pluginsGridView

        anchors.top: controlPanel.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 10
        anchors.rightMargin: 5
        anchors.topMargin: 10
        anchors.bottomMargin: 10

        clip: true

        readonly property int defaultCellWidth: 250
        readonly property int defaultCellHeight: 225

        cellWidth: Math.floor(width / Math.floor(width / defaultCellWidth))
        cellHeight: Math.floor((cellWidth / defaultCellWidth) * defaultCellHeight)

        onWidthChanged: {
            cellWidth: Math.floor(width / Math.floor(width / defaultCellWidth))
            cellHeight: Math.floor((cellWidth / defaultCellWidth) * defaultCellHeight)
        }

        ScrollBar.vertical: ScrollBar {
            id: vbar

            property int contentItemOffset: 4

            width: 12

            topPadding: width + 10
            bottomPadding: width + 10

            contentItem: Rectangle {
                id: vbarIndicator
                color: "#5A5A5A"
                radius: 10

                anchors.horizontalCenter: parent.horizontalCenter
            }

            background: Rectangle {
                id: vbarBG
                color: ColorThemes.layer_04
                radius: 10

                opacity: 0

                Behavior on opacity {
                    NumberAnimation { duration: 100 }
                }
            }

            onHoveredChanged: {
                internal.toggleScrollBar()
            }

            onPressedChanged: {
                internal.toggleScrollBar()
            }

            Image {
                id: vbarUpArrow
                source: 'qrc:/up_arrow.svg'
                sourceSize: Qt.size(parent.width - 4, parent.width)

                anchors.top: parent.top
                anchors.topMargin: 5
                anchors.horizontalCenter: parent.horizontalCenter

                opacity: 0

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
                id: vbarDownArrow
                source: 'qrc:/down_arrow.svg'
                sourceSize: Qt.size(parent.width - 4, parent.width)

                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5
                anchors.horizontalCenter: parent.horizontalCenter

                opacity: 0

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

        model: plugins

        delegate: Component {
            Rectangle {
                id: pluginDelegate
                radius: 10
                width: pluginsGridView.cellWidth - 15
                height: pluginsGridView.cellHeight - 15

                color: ColorThemes.layer_04
                border.color: "#5A5A5A"
                border.width: 1
                clip: true

//                layer.enabled: pluginDelegate.hovered | pluginDelegate.down
//                layer.effect: DropShadow {
//                    transparentBorder: true
//                    color: "#ffffff"
//                    samples: 10
//                }

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 10

                    spacing: 5

                    RowLayout {
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        Text {
                            id: pluginTitle
                            text: name //title
                            font.pointSize: 12
                            font.bold: true
                            color: ColorThemes.highEmphasisText
                            verticalAlignment: Text.AlignVCenter
                            Layout.preferredWidth: 3
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            elide: Text.ElideRight
                        }

                        Rectangle {
                            color: ColorThemes.layer_05
                            radius: 5
                            border.color: "#5A5A5A"
                            border.width: 1

                            Layout.preferredWidth: 2
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            Text {
                                   text: qsTr("Price")
                                   color: ColorThemes.helperText
                                   anchors.centerIn: parent
                            }
                        }
                    }

                    Text {
                        id: pluginDescription
                        text: description
                        font.pointSize: 10
                        color: ColorThemes.highEmphasisText
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

                Behavior on y {
                    NumberAnimation { duration: 75 }
                }

                property int y_pos: -1

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true

                    cursorShape: Qt.PointingHandCursor

                    onEntered: {
                        if (y_pos === -1)
                            y_pos = pluginDelegate.y
                        pluginDelegate.y = y_pos + 3
                    }

                    onExited: {
                        pluginDelegate.y = y_pos
                    }

                    onClicked: {
                        pluginPage.pluginPath = settingsPath
                        stackLayout.currentIndex = 1
                    }
                }

            }
        }

        focus: true
    }
}
