import QtQuick 2.15
import QtQuick.Controls.Basic
import QtQuick.Controls 2.5
import Qt5Compat.GraphicalEffects

import Themes 0.1

Button {
    id: btn
    text: qsTr("")
    visible:                                                                enabled? true : false

    property url btnIconSource:                                             "../../images/svg/menu.svg"

    property int iconWidth:                                                 15
    property int iconHeight:                                                15
    property int bgContainerWidth:                                          40
    property int bgContainerHeight:                                         35

    property color activeMenuColor:                                         "#9aa9ed"
    property bool isActive:                                                 false

    QtObject {
        id: internal

        property var dynamicColor: if(btn.down) {
                                       if(btn.down) {
                                           ColorThemes.btnColorClicked
                                       } else {
                                           isActive ? ColorThemes.btnColorActive : ColorThemes.btnColorDefault
                                       }
                                   } else {
                                       if(btn.hovered) {
                                           ColorThemes.btnColorActive
                                       } else {
                                           isActive ? ColorThemes.btnColorActive : ColorThemes.btnColorDefault
                                       }
                                   }
    }

    implicitWidth:                                                          bgContainerWidth
    implicitHeight:                                                         bgContainerHeight

    ColorOverlay {
        color:                                                              "#ffffff"
        anchors.fill:                                                       iconBtn

        source:                                                             iconBtn
    }

    Image {
        id: iconBtn

        source:                                                             btnIconSource
        sourceSize:                                                         Qt.size(iconWidth, iconHeight)
        visible:                                                            false

        anchors.left:                                                       parent.left
        anchors.leftMargin:                                                 12.5
        anchors.verticalCenter:                                             parent.verticalCenter
    }

    background: Rectangle {
        id: bg
        color:                                                              internal.dynamicColor

        radius:                                                             5

        /// Left Rectangle for active menu.
        Rectangle {
            color:                                                          activeMenuColor
            visible:                                                        isActive

            width:                                                          3
            height:                                                         iconHeight
            radius:                                                         5

            anchors.left:                                                   parent.left
            anchors.top:                                                    parent.top
            anchors.leftMargin:                                             0
            anchors.topMargin:                                              (bgContainerHeight - iconWidth) / 2

        }
    }

    contentItem: Text {
        id: contentText
        color:                                                              "#ffffff"

        text:                                                               btn.text
        font:                                                               btn.font

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
