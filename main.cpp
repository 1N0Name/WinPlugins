#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QLoggingCategory>
#include <QQuickStyle>

#include "appcore.h"
#include "modelpluginselection.h"
#ifdef PR_UNITS
    #include "tests/regapitest.h"
#endif

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
//    /* --------------------------- Turning on OpenGL. --------------------------- */
    QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts);
    /* -------------------------------------------------------------------------- */
    QGuiApplication app(argc, argv);
    // Default controls style
    QQuickStyle::setStyle("Universal");
    // Credentials
    app.setOrganizationName(QString("WinPlugins"));
    app.setApplicationName(QString("WinPlugins"));

/* ------------------------ Turn on/off QML logging. ------------------------ */
#ifndef PR_DEBUG
    QLoggingCategory::setFilterRules("*.debug=false\n"
                                     "*.info=false\n"
                                     "*.warning=false\n"
                                     "*.critical=true");
    fprintf(stderr, "Disabling QML logging in release build.\n");
#else
    fprintf(stderr, "QML logging enabled.\n");
#endif
/* -------------------------------------------------------------------------- */
    QQmlApplicationEngine engine;

    Appcore appcore;
    engine.rootContext()->setContextProperty("appcore", &appcore);

    ModelPluginSelection plugins;
    plugins.updateFromFileSystem();
    plugins.populate(5);
    engine.rootContext()->setContextProperty("plugins", &plugins);

#ifdef PR_UNITS
    QTest::qExec(new RegApiTest, argc, argv);
    return 0;
#endif

    engine.addImportPath("qrc:/");
    const QUrl url(u"qrc:/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
