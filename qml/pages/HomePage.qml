import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import Qt5Compat.GraphicalEffects

import Themes 0.1
import Texts 0.1
import Controls 0.1

ColumnLayout {
    id: root
    spacing: 10

    /* -------------------- Internal properties / functions. -------------------- */
    QtObject {
        id: internal
    }
    /* -------------------------------------------------------------------------- */

    Rectangle {
        id:controlPanel
        color: ColorThemes.transparent

        Layout.fillWidth: true
        Layout.preferredHeight: 45

        RowLayout {
            layoutDirection: Qt.RightToLeft
            spacing: 10

            anchors.fill: parent
            anchors.topMargin: 10
            anchors.leftMargin: pluginsGridView.anchors.leftMargin
            anchors.rightMargin: vbar.width + pluginsGridView.anchors.rightMargin * 2

            SearchBar {
                id: searchField

                onTextChanged: filteredPlugins.nameFilter = text;

                Layout.preferredWidth: searchField.searchBarWidth
                Layout.fillHeight: true
            }

            CustomComboBox {
                placeholderText: "Категория"
                Layout.fillHeight: true

                model: ListModel {
                    id: categoryModel
                    ListElement { text: "Все"; category: "" }
                    ListElement { text: "Контекстное меню"; category: "context" }
                    ListElement { text: "Таскбар"; category: "taskbar" }
                }
                onCurrentIndexChanged: {
                    // Tweak to prevent a random onExited event from triggering
                    plugins.updateFromFileSystem();
                    filteredPlugins.categoryFilter = categoryModel.get(currentIndex).category;
                }
            }

            CustomComboBox {
                placeholderText: "Стоимость"
                Layout.fillHeight: true

                model: ListModel {
                    id: priceModel
                    ListElement { text: "Все" }
                    ListElement { text: "Бесплатные" }
                }
            }

            Item {
                Layout.fillWidth: true
            }
        }
    }

    RoundRectangle {
        id: pluginsGridViewBackground
        color: ColorThemes.layer_02

        radius: 10
        radiusCorners: Qt.AlignLeft | Qt.AlignTop

        Layout.fillWidth: true
        Layout.fillHeight: true

        GridView {
            id: pluginsGridView

            anchors.fill: parent
            anchors.leftMargin: 10
            anchors.rightMargin: 5
            anchors.topMargin: 10

            clip: true

            readonly property int defaultCellWidth: 325
            readonly property int defaultCellHeight: 275

            cellWidth: (width / defaultCellWidth >= 3) ? Math.floor(width / Math.floor(width / defaultCellWidth))
                                                       : defaultCellWidth
            cellHeight: (width / defaultCellWidth >= 3) ? Math.floor((cellWidth / defaultCellWidth) * defaultCellHeight)
                                                        : defaultCellHeight

            ScrollBar.vertical: ScrollBar {
                id: vbar

                property int contentItemOffset: 2

                width: 12
                policy: ScrollBar.AlwaysOn

                topPadding: vbarUpArrow.height + vbarUpArrow.anchors.topMargin * 2
                bottomPadding: vbarDownArrow.height + vbarDownArrow.anchors.bottomMargin * 2

                contentItem: Rectangle {
                    id: vbarIndicator
                    color: ColorThemes.layer_04
                    radius: 10

                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: vbar.hovered ? vbar.contentItemOffset : !vbar.pressed
                                                       ? vbar.contentItemOffset * 2 : vbar.contentItemOffset
                    anchors.rightMargin: vbar.hovered ? vbar.contentItemOffset : !vbar.pressed
                                                        ? vbar.contentItemOffset * 2 : vbar.contentItemOffset
                }

                background: Rectangle {
                    id: vbarBG
                    visible: vbar.hovered || vbar.pressed
                    color: ColorThemes.layer_01
                    radius: 10

                    opacity: vbar.hovered ? 1 : !vbar.pressed ? 0 : 1

                    Behavior on opacity {
                        NumberAnimation { duration: 100 }
                    }
                }

                Image {
                    id: vbarUpArrow
                    source: 'qrc:/up_arrow.svg'
                    sourceSize: Qt.size(parent.width - 4, parent.width)

                    anchors.top: parent.top
                    anchors.topMargin: 4
                    anchors.horizontalCenter: parent.horizontalCenter

                    opacity: vbar.hovered ? 1 : !vbar.pressed ? 0 : 1

                    ColorOverlay {
                        anchors.fill: vbarUpArrow
                        source: vbarUpArrow
                        color: ColorThemes.activeIcon
                        antialiasing: true
                    }

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
                    anchors.bottomMargin: 4
                    anchors.horizontalCenter: parent.horizontalCenter

                    opacity: vbar.hovered ? 1 : !vbar.pressed ? 0 : 1

                    ColorOverlay {
                        anchors.fill: vbarDownArrow
                        source: vbarDownArrow
                        color: ColorThemes.activeIcon
                        antialiasing: true
                    }

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

            model: filteredPlugins

            delegate: pluginDelegateWrapper

            focus: true
        }

        Component {
            id: pluginDelegateWrapper

            Rectangle {
                id: pluginDelegate
                radius: 10
                width: pluginsGridView.cellWidth - 15
                height: pluginsGridView.cellHeight - 15

                required property int index
                required property string name
                required property string category
                required property string description
                required property string imgPath
                required property double price
                required property string settingsPath

                color: ColorThemes.layer_01
                clip: true

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 10

                    spacing: 5

                    RowLayout {
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        ColumnLayout {
                            Layout.preferredWidth: 2
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            HeaderText {
                                id: pluginTitle
                                text: name
                                color: ColorThemes.highEmphasisText
                                verticalAlignment: Text.AlignVCenter
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                elide: Text.ElideRight
                            }

                            HelperText {
                                id: pluginCategory
                                text: category
                                color: ColorThemes.helperText
                                verticalAlignment: Text.AlignVCenter
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                elide: Text.ElideRight
                            }
                        }

                        Item {
                            Layout.preferredWidth: 1
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            clip: true

                            Rectangle {
                                width: 75
                                height: 25
                                radius: 5
                                color: ColorThemes.layer_05

                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.margins: 0

                                RegularText {
                                   text: price === 0 ? "Бесплатно" : price
                                   color: ColorThemes.helperText
                                   anchors.fill: parent
                                   verticalAlignment: Text.AlignVCenter
                                   horizontalAlignment: Text.AlignHCenter
                                   elide: Text.ElideRight
                                }
                            }
                        }
                    }

                    RegularText {
                        id: pluginDescription
                        text: description
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

                property int y_pos: -1

                Behavior on y {
                    NumberAnimation { duration: 75 }
                }

                // Сorrecting the y position of the delegate
                onIndexChanged: y_pos = -1
                onWidthChanged: y_pos = -1

                MouseArea {
                    id: pluginDelegateMA
                    anchors.fill: parent
                    hoverEnabled: true

                    cursorShape: Qt.PointingHandCursor

                    onEntered: {
                        if (y_pos === -1)
                            y_pos = pluginDelegate.y
                        pluginDelegate.y = y_pos + 3
                    }

                    onExited: {
                        if (y_pos === -1)
                            y_pos = pluginDelegate.y
                        pluginDelegate.y = y_pos
                    }

                    onClicked: {
                        pluginPage.pluginPath                   = settingsPath
                        sideMenuBtnGroup.buttons[1].checked     = true
                        stackLayout.currentIndex                = 1
                    }
                }

                layer.enabled: pluginDelegateMA.containsMouse
                layer.effect: DropShadow {
                    transparentBorder: true
                    color: pluginDelegate.color
                    samples: 20
                }
            }
        }
    }
}
