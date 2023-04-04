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
    title: qsTr("ReFolder")
    color:                                                  ColorThemes.transparent

    width:                                                  1000
    height:                                                 600
    minimumWidth:                                           1000
    minimumHeight:                                          600
    visible:                                                true

    // Turning off default title bar.
    flags: Qt.Window | Qt.FramelessWindowHint

    FontLoader {
        id: montserratRegularFont

        source: "../../assets/fonts/Montserrat-Regular.ttf"
    }

    // Current windows states.
    property int windowStatus:                              0
    property int windowMargin:                              10

    /* -------------------- Internal properties / functions. -------------------- */
    QtObject {
        id: internal

        function resetResizeBorders() {
            resizeLeft.visible =                            true
            resizeRight.visible =                           true
            resizeBottom.visible =                          true
            windowResize.visible =                          true
        }

        function maximizeRestore() {
            if(windowStatus == 0) {
                windowStatus =                              1
                windowMargin =                              0
                appContainer.radius =                       0
                mainWindow.showMaximized()

                resizeLeft.visible =                        false
                resizeRight.visible =                       false
                resizeBottom.visible =                      false
                windowResize.visible =                      false

                btnMaximize.btnIconSource =                 "qrc:/maximize_restore_btn.svg"
            } else {
                windowStatus =                              0
                windowMargin =                              10
                appContainer.radius =                       10
                mainWindow.showNormal()
                resetResizeBorders()

                btnMaximize.btnIconSource =                 "qrc:/maximize_btn.svg"
            }
        }

        // Restore window after draging.
        function ifMaximizedRestore() {
            if (windowStatus == 1) {
                windowStatus =                              0
                windowMargin =                              10
                appContainer.radius =                       10
                resetResizeBorders()

                btnMaximize.btnIconSource =                 "qrc:/maximize_btn.svg"
            }
        }

        // Restore margins after minimization.
        function restoreMargins() {
            windowStatus =                                  0
            windowMargin =                                  10
            appContainer.radius =                           10
            resetResizeBorders()

            btnMaximize.btnIconSource =                     "qrc:/maxmimize_btn.svg"
        }
    }
    /* -------------------------------------------------------------------------- */

    /* ------------------------- Connection to AppCore. ------------------------- */
    Connections {
        target: appcore
    }
    /* -------------------------------------------------------------------------- */

    Rectangle {
        id: background
        color: ColorThemes.transparent
        z: 1

        anchors.left:                                       parent.left
        anchors.right:                                      parent.right
        anchors.top:                                        parent.top
        anchors.bottom:                                     parent.bottom
        anchors.leftMargin:                                 windowMargin
        anchors.rightMargin:                                windowMargin
        anchors.bottomMargin:                               windowMargin
        anchors.topMargin:                                  windowMargin

        Rectangle {
            id: appContainer
            color: ColorThemes.windowBackgroundColor
            radius:                                         10

            anchors.fill:                                   parent
            anchors.leftMargin:                             0
            anchors.rightMargin:                            0
            anchors.bottomMargin:                           0
            anchors.topMargin:                              0

            /* -------------------------------------------------------------------------- */
            /*                                  Top Bar.                                  */
            /* -------------------------------------------------------------------------- */
            Rectangle {
                id: topBar
                height: 50
                color: ColorThemes.transparent

                anchors.left:                               parent.left
                anchors.right:                              parent.right
                anchors.top:                                parent.top
                anchors.leftMargin:                         0
                anchors.rightMargin:                        0
                anchors.topMargin:                          0

                /* ---------------------------- Application Logo. --------------------------- */
                Rectangle {
                    id: appLogo
                    color:                                  ColorThemes.transparent

                    width: 50
                    height: 50
                    radius: 10

                    Image {
                        id: appLogoImage

                        source:                             "qrc:/assets/images/icons/logo.png"
                        fillMode:                           Image.PreserveAspectFit
                        mipmap:                             true

                        anchors.fill:                       parent
                        anchors.verticalCenter:             parent.verticalCenter
                        anchors.horizontalCenter:           parent.horizontalCenter
                    }

                    ColorOverlay {
                        anchors.fill:                       appLogoImage
                        source:                             appLogoImage
                        //color:                              ColorThemes.iconColor
                        antialiasing:                       true
                    }

                    anchors.left: parent.left
                    anchors.top: parent.rop
                }
                /* -------------------------------------------------------------------------- */

                /* ------------------------------- Title Bar. ------------------------------- */
                Rectangle {
                    id: titleBar
                    color: ColorThemes.transparent

                    height:                                 parent.height

                    anchors.left:                           parent.left
                    anchors.right:                          parent.right
                    anchors.top:                            parent.top
                    anchors.leftMargin:                     50
                    anchors.rightMargin:                    105
                    anchors.topMargin:                      0

                    // Adding ability to drag window.
                    DragHandler {
                        onActiveChanged: if(active) {
                                             mainWindow.startSystemMove()
                                             internal.ifMaximizedRestore()
                                         }
                    }

                    // App title.
                    Label {
                        id: appTitle
                        color: "#ffffff"
                        text: qsTr("WinPlugins")

                        font.family:                        montserratRegularFont.name
                        font.pointSize:                     12
                        font.bold:                          true
                        horizontalAlignment:                Text.AlignLeft
                        verticalAlignment:                  Text.AlignVCenter

                        anchors.left:                       parent.left
                        anchors.right:                      parent.right
                        anchors.top:                        parent.top
                        anchors.bottom:                     parent.bottom
                        anchors.leftMargin:                 5
                    }
                }
                /* -------------------------------------------------------------------------- */

                /* -------------------------- Windows control btns. ------------------------- */
                Row {
                    id: rowBtns
                    width: 105
                    height: 35

                    anchors.right:                          parent.right
                    anchors.top:                            parent.top
                    anchors.topMargin:                      0
                    anchors.rightMargin:                    0

                    TopBarBtn {
                        id: btnMinimize
                        btnIconSource:                      "qrc:/minimize_btn.svg"

                        onClicked: {
                            mainWindow.showMinimized()
                            internal.restoreMargins()
                        }
                    }

                    TopBarBtn {
                        id: btnMaximize
                        btnIconSource:                      "qrc:/maximize_btn.svg"

                        onClicked: internal.maximizeRestore()
                    }

                    TopBarBtn {
                        id: btnClose
                        btnIconSource:                      "qrc:/close_btn.svg"

                        btnColorMouseOver:                  ColorThemes.errorColor
                        btnColorClicked:                    Qt.darker(ColorThemes.errorColor, 1.2)

                        onClicked: mainWindow.close()
                    }
                }
            }
            /* -------------------------------------------------------------------------- */

            /* -------------------------------------------------------------------------- */
            /*                                Main Content.                               */
            /* -------------------------------------------------------------------------- */
            Rectangle {
                id: content
                color: ColorThemes.transparent

                anchors.left:                               parent.left
                anchors.right:                              parent.right
                anchors.top:                                topBar.bottom
                anchors.bottom:                             parent.bottom
                anchors.topMargin:                          0

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
                                        stackLayout.currentIndex = 2
                                    } else if (model.index === 3) {
                                        stackLayout.currentIndex = 1
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
                    }
                }
                /* -------------------------------------------------------------------------- */
            }
        }
    }

    /* -------------------------------------------------------------------------- */
    /*                            Window resize areas.                            */
    /* -------------------------------------------------------------------------- */

    // Left.
    MouseArea {
        id: resizeLeft
        width:                                              10

        anchors.left:                                       parent.left
        anchors.top:                                        parent.top
        anchors.bottom:                                     parent.bottom
        anchors.leftMargin:                                 0
        anchors.bottomMargin:                               10
        anchors.topMargin:                                  10

        cursorShape:                                        Qt.SizeHorCursor

        onPressed: {
            mainWindow.startSystemResize(Qt.LeftEdge)
        }
    }

    // Right.
    MouseArea {
        id: resizeRight
        width:                                              10

        anchors.right:                                      parent.right
        anchors.top:                                        parent.top
        anchors.bottom:                                     parent.bottom
        anchors.rightMargin:                                0
        anchors.bottomMargin:                               10
        anchors.topMargin:                                  10

        cursorShape:                                        Qt.SizeHorCursor

        onPressed: {
            mainWindow.startSystemResize(Qt.RightEdge)
        }
    }

    // Bottom.
    MouseArea {
        id: resizeBottom
        height:                                             10

        anchors.left:                                       parent.left
        anchors.right:                                      parent.right
        anchors.bottom:                                     parent.bottom
        anchors.rightMargin:                                10
        anchors.leftMargin:                                 10
        anchors.bottomMargin:                               0

        cursorShape:                                        Qt.SizeVerCursor

        onPressed: {
            mainWindow.startSystemResize(Qt.BottomEdge)
        }
    }


    // Top.
    MouseArea {
        id: resizeTop
        height:                                             10

        anchors.left:                                       parent.left
        anchors.right:                                      parent.right
        anchors.top:                                        parent.top
        anchors.topMargin:                                  0
        anchors.leftMargin:                                 10
        anchors.rightMargin:                                10

        cursorShape:                                        Qt.SizeVerCursor

        onPressed: {
            mainWindow.startSystemResize(Qt.TopEdge)
        }
    }

    // Bottom-right resize
    MouseArea {
        id: bottomRightResize

        width:                              25
        height:                             25

        anchors.right:                      parent.right
        anchors.bottom:                     parent.bottom
        anchors.bottomMargin:               0
        anchors.rightMargin:                0

        cursorShape:                        Qt.SizeFDiagCursor

        onPressed: {
            mainWindow.startSystemResize(Qt.RightEdge | Qt.BottomEdge)
        }

    }

    // Bottom-left resize
    MouseArea {
        id: bottomLeftResize

        width:                              25
        height:                             25

        anchors.left:                       parent.left
        anchors.bottom:                     parent.bottom
        anchors.bottomMargin:               0
        anchors.leftMargin:                 0

        cursorShape:                        Qt.SizeBDiagCursor

        onPressed: {
            mainWindow.startSystemResize(Qt.LeftEdge | Qt.BottomEdge)
        }

    }

    // Top-left resize
    MouseArea {
        id: leftTopResize

        width:                              25
        height:                             25

        anchors.left:                       parent.left
        anchors.top:                        parent.top
        anchors.topMargin:                  0
        anchors.leftMargin:                 0

        cursorShape:                        Qt.SizeFDiagCursor

        onPressed: {
            mainWindow.startSystemResize(Qt.LeftEdge | Qt.TopEdge)
        }

    }

    // Top-right resize
    MouseArea {
        id: rightTopResize

        width:                              25
        height:                             25

        anchors.right:                      parent.right
        anchors.top:                        parent.top
        anchors.topMargin:                  0
        anchors.rightMargin:                0

        cursorShape:                        Qt.SizeBDiagCursor

        onPressed: {
            mainWindow.startSystemResize(Qt.RightEdge | Qt.TopEdge)
        }

    }

    DropShadow {
        anchors.fill: background
        horizontalOffset: 0
        verticalOffset: 0
        radius: 10
        samples: 16
        color: "#80000000"
        source: background
        z: 0
    }
    /* -------------------------------------------------------------------------- */
}
