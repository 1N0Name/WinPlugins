import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt5Compat.GraphicalEffects

import Themes 0.1

TextField {
        id: root

        width:                                                      320

        color:                                                      ColorThemes.highEmphasisText
//        font.family:                                                Style.fontName
//        font.pointSize:                                             Style.fontSize
        verticalAlignment:                                          Text.AlignVCenter
        selectByMouse:                                              true

        leftPadding:                                                textFieldIcon.anchors.leftMargin * 3 + textFieldIcon.width + 1.01

        // Placeholder text.
        Text {
            text:                                                   qsTr("Введите название...")
            visible:                                                !root.text && !root.activeFocus

            color:                                                  ColorThemes.helperText
//            font.family:                                            Style.fontName
//            font.pointSize:                                         Style.fontSize

            anchors.top:                                            parent.top
            anchors.bottom:                                         parent.bottom
            anchors.left:                                           textFieldDelimeter.right
            anchors.leftMargin:                                     5
            verticalAlignment:                                      Text.AlignVCenter
        }

        Image {
            id: textFieldIcon
            source: "qrc:/search.svg"
            sourceSize:                                             Qt.size(18, 18)
            antialiasing: true
            fillMode:                                               Image.PreserveAspectFit

            anchors.left:                                           parent.left
            anchors.leftMargin:                                     (root.height - textFieldIcon.width) / 2
            anchors.verticalCenter:                                 parent.verticalCenter
        }

        // Delimeter.
        Rectangle {
            id: textFieldDelimeter
            width:                                                  1
            height:                                                 root.height
            color:                                                  "#5A5A5A"

            anchors.left:                                           parent.left
            anchors.leftMargin:                                     textFieldIcon.width + textFieldIcon.anchors.leftMargin * 2
        }

        ColorOverlay {
            anchors.fill:                                           textFieldIcon
            source:                                                 textFieldIcon
            color:                                                  ColorThemes.activeIcon
            antialiasing:                                           true
        }

        background: Rectangle {
            color:                                                  ColorThemes.layer_04
            radius:                                                 5
            border.width:                                           1
            border.color:                                           "#5A5A5A"
        }
    }
