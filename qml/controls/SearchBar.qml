import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt5Compat.GraphicalEffects

import Themes 0.1
import Texts 0.1

TextField {
    id: root

    property int searchBarWidth: 280

    width:                                                      searchBarWidth

    color:                                                      ColorThemes.highEmphasisText
    verticalAlignment:                                          Text.AlignVCenter
    selectByMouse:                                              true

    leftPadding:                                                placeholderText.leftPadding
    rightPadding:                                               textFieldIcon.anchors.rightMargin + textFieldIcon.width + 10

    // Placeholder text.
    RegularText {
        id:                                                     placeholderText
        text:                                                   qsTr("Введите название...")
        font.italic:                                            true
        visible:                                                !root.text && !root.activeFocus
        color:                                                  ColorThemes.helperText

        leftPadding:                                            10
        anchors.top:                                            parent.top
        anchors.bottom:                                         parent.bottom
        verticalAlignment:                                      Text.AlignVCenter
    }

    Image {
        id: textFieldIcon
        source: "qrc:/search.svg"
        sourceSize:                                             Qt.size(15, 15)
        antialiasing: true
        fillMode:                                               Image.PreserveAspectFit

        anchors.right:                                          parent.right
        anchors.rightMargin:                                    10
        anchors.verticalCenter:                                 parent.verticalCenter
    }

    ColorOverlay {
        anchors.fill:                                           textFieldIcon
        source:                                                 textFieldIcon
        color:                                                  ColorThemes.activeIcon
        antialiasing:                                           true
    }

    background: Rectangle {
        color:                                                  root.focus? ColorThemes.layer_04 : ColorThemes.layer_03
        radius:                                                 5
    }
}
