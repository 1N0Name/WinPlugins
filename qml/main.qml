import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import Qt5Compat.GraphicalEffects

import Themes 0.1

import "./qml/controls"
import "./qml/pages"

Window {
    id: mainWindow
    title: qsTr("WinPlugins")
    color:                                                  ColorThemes.layer_01

    width:                                                  1000
    height:                                                 600
    minimumWidth:                                           1000
    minimumHeight:                                          600
    visible:                                                true

    /* -------------------- Internal properties / functions. -------------------- */
    QtObject {
        id: internal

    }
    /* -------------------------------------------------------------------------- */

    /* ------------------------- Connection to AppCore. ------------------------- */
    Connections {
        target: appcore
    }
    /* -------------------------------------------------------------------------- */

    /* -------------------------------------------------------------------------- */
    /*                                Main Content.                               */
    /* -------------------------------------------------------------------------- */
    Rectangle {
        id: content
        color: ColorThemes.layer_01

        anchors.fill:                               parent

        /* ------------------------------- Side Menu. ------------------------------- */
        Rectangle {
            id: sideMenu
            color: ColorThemes.transparent
            state: 'close'
            clip: true

            anchors.left:                           parent.left
            anchors.top:                            parent.top
            anchors.bottom:                         parent.bottom
            anchors.leftMargin:                     0
            anchors.bottomMargin:                   0
            anchors.topMargin:                      0

            states: [
                State {
                    name: 'open'

                    PropertyChanges {
                        target: sideMenu
                        width: 180
                    }
                },
                State {
                    name: 'close'

                    PropertyChanges {
                        target: sideMenu
                        width: 50
                    }
                }
            ]

            transitions: [
                Transition {
                    from: 'close'
                    to: 'open'

                    NumberAnimation {
                        properties: 'width'
                        duration: 800
                        easing.type: Easing.InOutCubic
                    }
                },
                Transition {
                    from: 'open'
                    to: 'close'

                    NumberAnimation {
                        properties: 'width'
                        duration: 800
                        easing.type: Easing.InOutCubic
                    }
                }
            ]

            ColumnLayout {
                id: column

                anchors.fill: parent
                anchors.topMargin: 10
                spacing: 5

                ButtonGroup {
                    id: sideMenuBtnGroup
                    exclusive: true
                }

                SideMenuBtn {
                    text: ''
                    checkable: false

                    Layout.leftMargin: 5
                    Layout.alignment: Qt.AlignLeft
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40

                    btnIconSource: 'qrc:/menu.svg'

                    onClicked: {
                        if (sideMenu.state === 'close')
                            sideMenu.state = 'open';
                        else
                            sideMenu.state = 'close';
                    }
                }

                Repeater {
                    id: menuItems

                    Component.onCompleted: menuItems.itemAt(0).checked = true

                    model: ListModel {
                        ListElement { name: 'Home'; iconSource: 'qrc:/home.svg' }
                        ListElement { name: 'Library'; iconSource: 'qrc:/library.svg' }
                        ListElement { name: 'Settings'; iconSource: 'qrc:/settings.svg' }
                    }

                    delegate: SideMenuBtn {
                        text: name
                        ButtonGroup.group: sideMenuBtnGroup

                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: parent.width - 10
                        Layout.preferredHeight: 40

                        btnIconSource: iconSource

                        onClicked: stackLayout.currentIndex = index
                    }
                }

                Item {
                    Layout.fillHeight: true
                }
            }
        }
        /* -------------------------------------------------------------------------- */

        /* --------------------------------- Pages. --------------------------------- */
        Rectangle {
            id: contentPages
            color: ColorThemes.transparent
            clip: true

            anchors.left:                           sideMenu.right
            anchors.right:                          parent.right
            anchors.top:                            parent.top
            anchors.bottom:                         parent.bottom
            anchors.bottomMargin:                   0
            anchors.rightMargin:                    0
            anchors.leftMargin:                     0
            anchors.topMargin:                      0

            StackLayout {
                id: stackLayout
                anchors.fill: parent
                currentIndex: 0

                HomePage {
                    id: homePage
                }
                PluginPage {
                    id: pluginPage
                }
                SettingsPage {
                    id: settingsPage
                }
            }
        }
        /* -------------------------------------------------------------------------- */
    }
    /* -------------------------------------------------------------------------- */
}
