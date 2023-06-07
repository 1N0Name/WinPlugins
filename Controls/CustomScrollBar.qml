import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt5Compat.GraphicalEffects

import Themes 0.1

ScrollBar {
    id: root

    property int contentItemOffset: 2
    property var scrollTarget: parent

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
        anchors.leftMargin: root.hovered ? root.contentItemOffset : !root.pressed
                                           ? root.contentItemOffset * 2 : root.contentItemOffset
        anchors.rightMargin: root.hovered ? root.contentItemOffset : !root.pressed
                                            ? root.contentItemOffset * 2 : root.contentItemOffset
    }

    background: Rectangle {
        id: vbarBG
        visible: root.hovered || root.pressed
        color: ColorThemes.layer_01
        radius: 10

        opacity: root.hovered ? 1 : !root.pressed ? 0 : 1

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

        opacity: root.hovered ? 1 : !root.pressed ? 0 : 1

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
                target: scrollTarget
                property: "contentY"
                running: upButton.pressed
                velocity: 1000
                to: 0
            }

            onReleased: {
                if (!scrollTarget.atYBeginning)
                    scrollTarget.flick(0, 1000)
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

        opacity: root.hovered ? 1 : !root.pressed ? 0 : 1

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
                target: scrollTarget
                property: "contentY"
                running: downButton.pressed
                to: scrollTarget.contentHeight - scrollTarget.height
                velocity: 1000
            }

            onReleased: {
                if (!scrollTarget.atYEnd)
                    scrollTarget.flick(0, -1000)
            }
        }
    }
}
