#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QLoggingCategory>
#include <GlobalParameters.h>
#include <modelpluginselection.h>
#include <appcore.h>
#include <tests/regapitest.h>

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    /* --------------------------- Turning on OpenGL. --------------------------- */
    QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts);
    /* -------------------------------------------------------------------------- */
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine; 

/* ------------------------ Turn on/off QML logging. ------------------------ */
#if !PR_DEBUG
    QLoggingCategory::setFilterRules("*.debug=false\n"
                                     "*.info=false\n"
                                     "*.warning=false\n"
                                     "*.critical=true");
    fprintf(stderr, "Disabling QML logging in release build.\n");
#else
    fprintf(stderr, "QML logging enabled.\n");
#endif
/* -------------------------------------------------------------------------- */

    engine.addImportPath("qrc:/");
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);
    Appcore appcore;
    ModelPluginSelection plugins;
#if PR_DEBUG
    plugins.populate(20);
#else
    plugins.updateFromFileSystem();
#endif
    engine.rootContext()->setContextProperty("appcore", &appcore);
    engine.rootContext()->setContextProperty("plugins", &plugins);
#if PR_UNITS
    QTest::qExec(new RegApiTest, argc, argv);
    return 0;
#endif

    return app.exec();
}
