pragma Singleton

import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: item

    property alias themes: m_themes;

    QtObject {
        id: m_themes

        readonly property var light: [ "#ede9ed", "#fffbff", "#d5d1d5", "#c2bcc2", "#e5c1d5",
            "#DE61619c", "#99000000", "#DE000000", "#99000000"

        ];

        readonly property var dark:  [ "#28262c", "#1c1b1f", "#33303a", "#44414B", "#5f3c51",
            "#DEc0c1ff", "#99b3b3b3", "#DEffffff", "#99ffffff"
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
