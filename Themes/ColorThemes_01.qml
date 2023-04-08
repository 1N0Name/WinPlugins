pragma Singleton

import QtQuick 2.9
import QtQuick.Controls 2.5

Item {
    id: item

    property alias themes: m_themes;

    QtObject {
        id: m_themes

        readonly property var light: [ "#f0f0f0", "#f3f3f3", "#fbfbfb", "#fefefe", "#ffffff",
            "#DE000000", "#99000000", "#DE000000", "#99000000"

        ];

        readonly property var dark:  [ "#1e1e1e", "#222222", "#242424", "#272727", "#2c2c2c",
            "#DEffffff", "#99ffffff", "#DEffffff", "#99ffffff"
        ];
    }

    property var currentTheme: themes.dark

    /* ------------------------ Default color properties. ----------------------- */
    readonly property string transparent:                       "#00000000"

    readonly property string layer_01:                          currentTheme[0]
    readonly property string layer_02:                          currentTheme[1]
    readonly property string layer_03:                          currentTheme[2]
    readonly property string layer_04:                          currentTheme[3]
    readonly property string layer_05:                          currentTheme[4]

    readonly property string activeIcon:                        currentTheme[5]
    readonly property string inActiveIcon:                      currentTheme[6]

    readonly property string highEmphasisText:                  currentTheme[7]
    readonly property string helperText:                        currentTheme[8]
    /* -------------------------------------------------------------------------- */
}
