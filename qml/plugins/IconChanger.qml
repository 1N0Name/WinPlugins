import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt.labs.platform 1.1
import Qt5Compat.GraphicalEffects

import Themes 0.1
import Texts 0.1

import "../controls"

Rectangle {
    id: background
    color: ColorThemes.layer_02

    Rectangle {
        color: ColorThemes.layer_01
        radius: 10

        anchors.fill: parent
        anchors.topMargin: 30
        anchors.bottomMargin: 30
        anchors.leftMargin: 200
        anchors.rightMargin: 200

        ColumnLayout {
            spacing: 10

            anchors.fill: parent
            anchors.margins: 10

            HeaderText {
                text: qsTr("IconChanger")
                color: ColorThemes.highEmphasisText
                Layout.fillWidth: true
                horizontalAlignment: Qt.AlignHCenter
            }

            CustomTextField {
                id: folderPathInput
                customPlaceholderText: qsTr("Введите абсолютный путь к папке...")
                rightPadding: 45

                Layout.fillWidth: true

                Image {
                    id: folderSource
                    source: "qrc:/folder.svg"
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
                        onFolderChanged: folderPathInput.text = folder
                    }
                }

                ColorOverlay {
                    anchors.fill: folderSource
                    source: folderSource
                    color: folderSourceMA.containsMouse ? ColorThemes.activeIcon : ColorThemes.inActiveIcon
                    antialiasing: true
                }
            }

            CustomTextField {
                id: iconPathInput
                customPlaceholderText: qsTr("Введите абсолютный путь к иконке...")
                rightPadding: 45

                Layout.fillWidth: true

                Image {
                    id: iconSource
                    source: "qrc:/image.svg"
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
                        onFileChanged: iconPathInput.text = file
                    }
                }

                ColorOverlay {
                    anchors.fill: iconSource
                    source: iconSource
                    color: iconSourceMA.containsMouse ? ColorThemes.activeIcon : ColorThemes.inActiveIcon
                    antialiasing: true
                }
            }

            RowLayout {

                Layout.fillWidth: true
                Layout.fillHeight: false

                CustomButton {
                    id: iconRegistryDisplaySwitchBtn
                    text: qsTr("Реестр иконок")
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignLeft

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
                    onClicked: iconRegistryDisplayBG.targetHeight = activeIconsDisplayBG.height
                }

                CheckBox {
                    text: qsTr("Запомнить в реестре")
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }

                CustomButton {
                    text: qsTr("Применить")
                    width: 100

                    Layout.fillWidth: true
                }
            }

            Rectangle {
                id: iconRegistryDisplayBG
                color: ColorThemes.layer_03
                radius: 10
                state: 'invisible'
                Layout.fillWidth: true

                GridView {
                    id: iconRegistryDisplay
                    clip: true

                    anchors.fill: parent
                    anchors.leftMargin: 10
                    anchors.rightMargin: 5
                    anchors.topMargin: 10
                }

                property int targetHeight

                states: [
                    State {
                        name: 'visible'
                        when: iconRegistryDisplaySwitchBtn.checked
                        PropertyChanges { target: iconRegistryDisplayBG; Layout.preferredHeight: Math.floor(targetHeight / 2 - 10) }
                    },
                    State {
                        name: 'invisible'
                        when: !iconRegistryDisplaySwitchBtn.checked
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
                Layout.fillHeight: true

                ListView {
                    id: activeIconsDisplay
                    clip: true

                    anchors.fill: parent
                    anchors.leftMargin: 10
                    anchors.rightMargin: 5
                    anchors.topMargin: 10
                }
            }
        }
    }
}
