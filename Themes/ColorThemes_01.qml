pragma Singleton

import QtQuick 2.9
import QtQuick.Controls 2.5

Item {
    id: item

    QtObject {
        id: themes

        readonly property var light: [ "#202020",  "#272727", "#323232", "#373737", "#ffffff",
            "#00000000", "#2d2d2d", "#292929","#9aa9ed", Qt.lighter("#9aa9ed", 1.2),
            Qt.darker("#9aa9ed", 1.2), "#000000", "#CF6679"
        ];

        readonly property var dark: [ "#202020",  "#272727", "#323232", "#373737", "#ffffff",
            "#00000000", "#2d2d2d", "#292929","#9aa9ed", Qt.lighter("#9aa9ed", 1.2),
            Qt.darker("#9aa9ed", 1.2), "#000000", "#CF6679"
        ];
    }

    property var currentTheme: themes.dark

    /* ------------------------ Default color properties. ----------------------- */
     property string transparent:                     "#00000000"

    readonly property string windowBackgroundColor:           currentTheme[0]
    readonly property string pageBackgroundColor:             currentTheme[1]
    readonly property string containerBackgroundColor:        currentTheme[2]
    readonly property string delegateColor:                   currentTheme[3]
    readonly property string iconColor:                       currentTheme[4]
    /* -------------------------------------------------------------------------- */

    /* -------------------------- Btn Color properties. ------------------------- */
    readonly property string btnColorDefault:                 currentTheme[5]
    readonly property string btnColorActive:                  currentTheme[6]
    readonly property string btnColorClicked:                 currentTheme[7]

    readonly property string primaryColor:                    currentTheme[8]
    readonly property string primaryHoveredColor:             currentTheme[9]
    readonly property string primaryClickedColor:             currentTheme[10]
    readonly property string secondaryColor:                  currentTheme[11]
    readonly property string errorColor:                      currentTheme[12]
    /* -------------------------------------------------------------------------- */
}
