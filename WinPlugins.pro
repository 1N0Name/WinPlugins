# https://dragly.org/2014/03/13/new-project-structure-for-projects-in-qt-creator-with-unit-tests/

QT += \
    quick \
    quickcontrols2

# Key States
DEFINES += \
    PR_DEBUG \
#    PR_UNITS

CONFIG(release, debug|release){
    # code for Release builds
} else {
    # code for Debug builds
    QT += testlib
    SOURCES += tests/regApiTest.cpp
    HEADERS += tests/regapitest.h

    CONFIG += file_copies
    COPIES += plugins
    plugins.files = $$files(DistPkg/*)
    plugins.path = $$OUT_PWD
}

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        appcore.cpp \
        main.cpp \
        modelpluginselection.cpp \
        plugin.cpp \
        regapi.cpp

RESOURCES += \
    qml.qrc \
    images.qrc

RC_ICONS = WinPlugins.ico

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH += $$PWD

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    appcore.h \
    modelpluginselection.h \
    plugin.h \
    regapi.h
