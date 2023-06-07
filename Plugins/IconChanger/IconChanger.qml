import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt.labs.platform 1.1
import Qt5Compat.GraphicalEffects

import Themes 0.1
import Texts 0.1
import Controls 0.1
import IconChanger 0.1
import filetype 1.0

ColumnLayout {
    id: root
    spacing: 0

    Rectangle {
        id:controlPanel
        color: ColorThemes.layer_01

        Layout.fillWidth: true
        Layout.preferredHeight: 45

        HeaderText {
            text: qsTr("IconChanger")
            color: ColorThemes.highEmphasisText

            anchors.fill: parent
            leftPadding: 30
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
        }
    }

    ScrollView {
        Layout.fillWidth: true
        Layout.fillHeight: true

        ScrollBar.vertical: contentSB

        RoundRectangle {
            id: contentBG
            color: ColorThemes.layer_02

            radius: 10
            radiusCorners: Qt.AlignLeft | Qt.AlignTop

            anchors.fill: parent

            CustomScrollBar {
                id: contentSB
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.right: parent.right
            }

            ColumnLayout {
                id: contentLayout
                spacing: 10

                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: contentSB.left
                anchors.rightMargin: 5

                CustomTextField {
                    id: folderPathInput
                    customPlaceholderText: qsTr("Введите абсолютный путь к папке...")
                    rightPadding: 45

                    Layout.fillWidth: true

                    Image {
                        id: folderSource
                        source: "qrc://Plugins/IconChanger/assets/folder.svg"
                        sourceSize: Qt.size(30, 30)

                        CustomToolTip {
                            visible: folderSourceMA.containsMouse
                            text: "Выберите директорию..."
                        }

                        anchors.right: parent.right
                        anchors.rightMargin: 5
                        anchors.verticalCenter: parent.verticalCenter

                        MouseArea {
                            id: folderSourceMA
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: folderDialog.open()
                        }

                        FolderDialog {
                            id: folderDialog
                            currentFolder: ""
                            onFolderChanged: folderPathInput.text = folder.toString().replace("file:///","")
                        }
                    }

                    ColorOverlay {
                        anchors.fill: folderSource
                        source: folderSource
                        color: folderSourceMA.containsMouse ? ColorThemes.activeIcon : ColorThemes.inActiveIcon
                        antialiasing: true
                    }

                    onTextChanged: folderPathInput.text === '' ? folderPathInput.state = 'active' : pluginsApi.checkIfExists(text, FileType.FOLDER)
                                                               ? folderPathInput.state = 'success' : folderPathInput.state = 'error'
                }

                CustomTextField {
                    id: iconPathInput
                    customPlaceholderText: qsTr("Введите абсолютный путь к иконке...")
                    rightPadding: 45
                    Layout.fillWidth: true

                    Image {
                        id: iconSource
                        source: "qrc://Plugins/IconChanger/assets/icon.svg"
                        sourceSize: Qt.size(30, 30)

                        CustomToolTip {
                            visible: iconSourceMA.containsMouse
                            text: "Выбирите .ico или .png иконку..."
                        }

                        anchors.right: parent.right
                        anchors.rightMargin: 5
                        anchors.verticalCenter: parent.verticalCenter

                        MouseArea {
                            id: iconSourceMA
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: iconDialog.open()
                        }

                        FileDialog {
                            id: iconDialog
                            currentFile: ""
                            nameFilters: ["Icon files (*.ico)", "PNG files (*.png)"]
                            onFileChanged: iconPathInput.text = file.toString().replace("file:///","")
                        }
                    }

                    ColorOverlay {
                        anchors.fill: iconSource
                        source: iconSource
                        color: iconSourceMA.containsMouse ? ColorThemes.activeIcon : ColorThemes.inActiveIcon
                        antialiasing: true
                    }

                    onTextChanged: iconPathInput.text === '' ? iconPathInput.state = 'default' : pluginsApi.checkIfExists(text, FileType.FILE)
                                                             ? iconPathInput.state = 'success' : iconPathInput.state = 'error'
                }

                RowLayout {
                    spacing: 10
                    Layout.fillWidth: true

                    CustomButton {
                        id: iconRegistryDisplaySwitchBtn
                        text: qsTr("Реестр иконок")
                        checkable: true

                        rightPadding: indicatorIcon.width + leftPadding + 10

                        Image {
                            id: indicatorIcon
                            x: iconRegistryDisplaySwitchBtn.width - width - 10
                            anchors.verticalCenter: parent.verticalCenter

                            source: 'qrc:/up_arrow.svg'
                            sourceSize: Qt.size(12, 12)

                            ColorOverlay {
                                anchors.fill: indicatorIcon
                                source: indicatorIcon
                                color: iconRegistryDisplaySwitchBtn.checked ? ColorThemes.activeIcon
                                                                            : ColorThemes.inActiveIcon
                                antialiasing: true
                            }

                            Behavior on rotation {
                                NumberAnimation { duration: 75 }
                            }
                        }

                        onCheckedChanged: iconRegistryDisplaySwitchBtn.checked ? indicatorIcon.rotation = 180
                                                                               : indicatorIcon.rotation = 0
                        onClicked: iconRegistryDisplayBG.state === 'invisible' ? iconRegistryDisplayBG.state = 'visible'
                                                                               : iconRegistryDisplayBG.state = 'invisible'
                    }

                    CustomCheckBox {
                        text: qsTr("Запомнить в реестре")
                    }
                }

                Rectangle {
                    id: iconRegistryDisplayBG
                    color: ColorThemes.layer_03
                    clip: true
                    radius: 10
                    state: 'invisible'
                    Layout.fillWidth: true

                    IconModel {
                        id: iconModel
                    }

                    GridView {
                        id: iconRegistryDisplay

                        property int iconSize: 64

                        cellWidth: iconSize + 10
                        cellHeight: iconSize + 10

                        anchors.fill: parent
                        anchors.leftMargin: 10
                        anchors.rightMargin: 5
                        anchors.topMargin: 10

                        model: iconModel

                        delegate: Rectangle {
                            id: repositoryIcon
                            color: ColorThemes.layer_04
                            radius: 5
                            width: iconRegistryDisplay.iconSize
                            height: iconRegistryDisplay.iconSize

                            Image {
                                id: repositoryIconPreview
                                source: icon
                                fillMode: Image.PreserveAspectCrop
                                anchors.fill: parent
                                anchors.margins: 5
                            }

                            Image {
                                id: delBtn
                                source: "qrc://Plugins/IconChanger/assets/delete.svg"
                                sourceSize: Qt.size(15, 15)
                                anchors.right: repositoryIcon.right
                                anchors.top: repositoryIcon.top
                                anchors.rightMargin: Math.floor(width / 2 * -1)
                                anchors.topMargin: Math.floor(height / 2 * -1)

                                MouseArea {
                                    anchors.fill: parent
                                    enabled: false
                                    cursorShape: Qt.PointingHandCursor
                                }
                            }

                            ColorOverlay {
                                anchors.fill: delBtn
                                source: delBtn
                                color: ColorThemes.highEmphasisText
                                antialiasing: true
                            }

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: iconPathInput.text = repositoryIconPreview.source.toString().replace("file:///","")
                            }
                        }
                    }

                    states: [
                        State {
                            name: 'visible'
                            PropertyChanges { target: iconRegistryDisplayBG; Layout.preferredHeight: activeIconsDisplayBG.Layout.preferredHeight / 2 }
                        },
                        State {
                            name: 'invisible'
                            PropertyChanges { target: iconRegistryDisplayBG; Layout.preferredHeight: 0 }
                        }
                    ]

                    Behavior on Layout.preferredHeight {
                        NumberAnimation { duration: 350 }
                    }
                }

                Rectangle {
                    id: activeIconsDisplayBG
                    color: ColorThemes.layer_03
                    radius: 10

                    Layout.fillWidth: true
                    Layout.preferredHeight: 400

                    ColumnLayout {
                        spacing: 10

                        anchors.fill: parent
                        anchors.margins: 10

                        RegularText {
                            text: qsTr("Список изменений")
                            color: ColorThemes.highEmphasisText
                            Layout.fillWidth: true
                        }

                        ListView {
                            id: activeIconsDisplay
                            clip: true

                            Layout.fillWidth: true
                            Layout.fillHeight: true
                        }
                    }
                }
            }
        }
    }

    Rectangle {
        id: bottomControlPanel
        color: ColorThemes.layer_02

        Layout.fillWidth: true
        Layout.preferredHeight: 60

        CustomButton {
            text: qsTr("Применить")
            textAlignment: Qt.AlignHCenter

            width: 100
            anchors.right: parent.right
            anchors.rightMargin: 15
        }
    }
}