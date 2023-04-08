import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Universal 2.3
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import Qt5Compat.GraphicalEffects

import Themes 0.1

import "qml/controls"
import "qml/pages"

Window {
    id: mainWindow
    title: qsTr("WinPlugins")
    color:                                                  ColorThemes.layer_01

    width:                                                  1000
    height:                                                 600
    minimumWidth:                                           1000
    minimumHeight:                                          600
    visible:                                                true

    FontLoader {
        id: montserratRegularFont

        source: "../../assets/fonts/Montserrat-Regular.ttf"
    }

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
        anchors.topMargin: 15

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
                spacing: 5

                Repeater {
                    id: menuItems

                    Component.onCompleted: {
                        menuItems.itemAt(1).isActive = true
                    }

                    property int prevActive: 1

                    model: ListModel {
                        ListElement { name: ''; iconSource: 'qrc:/menu.svg' }
                        ListElement { name: 'Home'; iconSource: 'qrc:/home.svg' }
                        ListElement { name: 'Library'; iconSource: 'qrc:/library.svg' }
                        ListElement { name: 'Settings'; iconSource: 'qrc:/settings.svg' }
                    }

                    delegate: SideMenuBtn {
                        text: name

                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: parent.width - 10
                        Layout.preferredHeight: 35

                        btnIconSource: iconSource

                        onClicked: {
                            // Highlighting the active element
                            if (model.index === index && model.index !== 0) {
                                menuItems.itemAt(menuItems.prevActive).isActive = false
                                isActive = true
                                menuItems.prevActive = index
                            }

                            if (model.index === 0) {
                                if (sideMenu.state === 'close')
                                    sideMenu.state = 'open';
                                else
                                    sideMenu.state = 'close';
                            } else if (model.index === 1) {
                                stackLayout.currentIndex = 0
                            } else if (model.index === 2) {
                                stackLayout.currentIndex = 1
                            } else if (model.index === 3) {
                                stackLayout.currentIndex = 2
                            }
                        }
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
