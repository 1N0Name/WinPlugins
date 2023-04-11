import QtQuick 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import Qt5Compat.GraphicalEffects
import QtQuick.Controls.Material 2.3

import Themes 0.1

import "../controls"

RoundRectangle {
    id: background
    color: ColorThemes.layer_02
    radius: 10
    radiusCorners: Qt.AlignLeft | Qt.AlignTop

    property string pluginPath

    clip: true

    Loader {
        id: loader
        anchors.fill: parent
        source: pluginPath
    }
}
