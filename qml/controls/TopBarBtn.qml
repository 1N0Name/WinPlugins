import QtQuick 2.15
import QtQuick.Controls.Basic
import QtQuick.Controls 2.5
import Qt5Compat.GraphicalEffects

import Themes 0.1

Button {
    id: btnTopBar

    clip: true

    property url btnIconSource:                                             "../../images/svg/minmize.svg"

    property alias btnWidth:                                                btnTopBar.width
    property alias btnHeight:                                               btnTopBar.height
    property color btnColorDefault:                                         ColorThemes.btnColorDefault
    property color btnColorMouseOver:                                       ColorThemes.btnColorActive
    property color btnColorClicked:                                         ColorThemes.btnColorClicked

    QtObject {
        id: internal

        property var dynamicColor: if(btnTopBar.down) {
                                       btnTopBar.down ? btnColorClicked : btnColorDefault
                                   } else {
                                       btnTopBar.hovered ? btnColorMouseOver : btnColorDefault
                                   }
    }


    width: 35
    height: 35

    background: Rectangle {
        id: bgBtn
        color:                                                              internal.dynamicColor

        Image {
            id: iconBtn
            source:                                                         btnIconSource
            sourceSize:                                                     Qt.size(16, 16)

            anchors.verticalCenter:                                         parent.verticalCenter
            anchors.horizontalCenter:                                       parent.horizontalCenter
            visible:                                                        false
        }

        ColorOverlay {
            anchors.fill:                                                   iconBtn
            source:                                                         iconBtn
            color:                                                          "#ffffff"
            antialiasing:                                                   true
        }
    }
}
