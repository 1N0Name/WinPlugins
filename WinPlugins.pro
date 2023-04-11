# https://dragly.org/2014/03/13/new-project-structure-for-projects-in-qt-creator-with-unit-tests/

QT += \
    quick \
    quickcontrols2

# Key States
DEFINES += \
    PR_DEBUG \
#    PR_UNITS

# Recursive remove directory
defineTest(removeDirRecursive) {
    DIR_TO_DEL = $$shell_path($$1)
    RETURN = $$escape_expand(\n\t)
    QMAKE_POST_LINK += $$RETURN $$QMAKE_DEL_TREE $$quote($$DIR_TO_DEL)
    export(QMAKE_POST_LINK)
}

# create directory if not exist, then copy some files to that directory
defineTest(copyFilesToDir) {
    COPY_DIR = $$shell_path($$1)
    DIR = $$shell_path($$2)
    RETURN = $$escape_expand(\n\t)
    QMAKE_POST_LINK += $$RETURN $$sprintf($$QMAKE_MKDIR_CMD, $$DIR)
    QMAKE_POST_LINK += $$RETURN $$QMAKE_COPY_DIR $$quote($$COPY_DIR) $$quote($$DIR)
    export(QMAKE_POST_LINK)
}

#copyFilesToDir(some/*.dll, $$DESTDIR/other)

CONFIG(release, debug|release) {
    # code for Release builds
} else {
    # code for Debug builds
    QT += testlib
    SOURCES += tests/regApiTest.cpp
    HEADERS += tests/regapitest.h

#    removeDirRecursive($$OUT_PWD/plugins)
#    copyFilesToDir($$PWD/DistPkg, $$OUT_PWD)

#    CONFIG += file_copies
#    COPIES += plugins
#    plugins.files = $$files(DistPkg/*)
#    plugins.path = $$OUT_PWD
}

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        appcore.cpp \
        main.cpp \
        modelpluginselection.cpp \
        modelsortplugins.cpp \
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
    modelsortplugins.h \
    plugin.h \
    regapi.h
