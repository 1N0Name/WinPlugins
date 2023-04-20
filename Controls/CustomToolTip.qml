import QtQuick 2.15
import QtQuick.Controls 2.15

import Themes 0.1
import Texts 0.1

ToolTip {
    id: root

    contentItem: RegularText {
        text: root.text
        color: ColorThemes.helperText
    }

    background: Rectangle {
        radius: 5
        color: ColorThemes.layer_04
    }
}
