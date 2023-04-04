import QtQuick 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import Qt5Compat.GraphicalEffects
import QtQuick.Controls.Material 2.3

import Themes 0.1

Rectangle {
    id: background
    color: ColorThemes.pageBackgroundColor
    radius: 10

    property string pluginPath

    clip: true

    Loader {
        id: loader
        anchors.fill: parent
        source: pluginPath
    }

    /*MouseArea {
        anchors.fill: parent
        onClicked: {
            console.log("clicked");
            //loader.setSource("file:///D:/Desktop/WinPlugins/WinPlugins/DistPkg/plugins/CustomContextMenu/CCM.qml")
            loader.setSource(pluginPath)
        }
    }*/
}
