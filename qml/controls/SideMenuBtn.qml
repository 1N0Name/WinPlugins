import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt5Compat.GraphicalEffects

import Themes 0.1
import Texts 0.1

Button {
    id: root
    text: qsTr("")
    visible:                                                                enabled? true : false

    property url btnIconSource:                                             "../../images/svg/menu.svg"

    property int iconWidth:                                                 25
    property int iconHeight:                                                25
    property int bgContainerWidth:                                          60
    property int bgContainerHeight:                                         40

    checkable: true

    QtObject {
        id: internal

        property var buttonDynamicColor:    if (root.down) {
                                                if (root.down) {
                                                   ColorThemes.layer_04
                                                } else {
                                                   checked ? ColorThemes.layer_03 : ColorThemes.layer_01
                                                }
                                            } else {
                                                if (root.hovered) {
                                                   ColorThemes.layer_03
                                                } else {
                                                   checked ? ColorThemes.layer_03 : ColorThemes.layer_01
                                                }
                                            }

        property var iconDynamicColor:      if (checked) {
                                                ColorThemes.activeIcon
                                            } else {
                                                ColorThemes.inActiveIcon
                                            }

    }

    implicitWidth:                                                          bgContainerWidth
    implicitHeight:                                                         bgContainerHeight

    ColorOverlay {
        anchors.fill:                                                       iconBtn
        source:                                                             iconBtn

        color:                                                              internal.iconDynamicColor

        antialiasing:                                                       true
    }

    Image {
        id: iconBtn

        source:                                                             btnIconSource
        sourceSize:                                                         Qt.size(iconWidth, iconHeight)
        visible:                                                            false

        anchors.left:                                                       parent.left
        anchors.leftMargin:                                                 indicator.width + 5
        anchors.verticalCenter:                                             parent.verticalCenter
    }

    background: Rectangle {
        id: bg
        color:                                                              internal.buttonDynamicColor

        radius:                                                             5

        // Active element selection.
        Rectangle {
            id: indicator
            color:                                                          ColorThemes.layer_05
            visible:                                                        checked

            width:                                                          3
            height:                                                         20
            radius:                                                         5

            anchors.left:                                                   parent.left
            anchors.leftMargin:                                             0
            anchors.verticalCenter:                                         parent.verticalCenter
        }
    }

    contentItem: RegularText {
        id: contentText
        text:                                                               root.text
        color:                                                              ColorThemes.highEmphasisText

        anchors.left:                                                       parent.left
        anchors.leftMargin:                                                 50
        verticalAlignment:                                                  Text.AlignVCenter
    }

    MouseArea {
        anchors.fill: parent
        enabled: false
        cursorShape: Qt.PointingHandCursor
    }
}
