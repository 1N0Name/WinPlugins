import QtQuick 2.15
import QtQuick.Controls 2.15

import Themes 0.1
import Texts 0.1

TextField {
    id: root
    height: 40
    width: 175

    color: ColorThemes.highEmphasisText

    property string customPlaceholderText

    // Placeholder text.
    RegularText {
        id: placeholderText
        text: customPlaceholderText
        font.italic: true
        visible: !root.text && !root.activeFocus
        color: ColorThemes.helperText

        leftPadding: 10
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        verticalAlignment: Text.AlignVCenter
    }

    background: Rectangle {
        id: rootBG
        implicitHeight: root.height
        implicitWidth: root.width
        color: ColorThemes.layer_03
        border.width: 1
        border.color: focus? ColorThemes.layer_04 : ColorThemes.layer_03
        radius: 5
    }

    states: [
        State {
            name: 'default'
            PropertyChanges { target: rootBG; border.color: ColorThemes.layer_03 }
        },
        State {
            name: 'error'
            PropertyChanges { target: rootBG; border.color: ColorThemes.error }
        },
        State {
            name: 'success'
            PropertyChanges { target: rootBG; border.color: ColorThemes.success }
        }
    ]
}
