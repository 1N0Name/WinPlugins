#include <QGuiApplication>
#include <QLoggingCategory>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>

#include "lib/appcore.h"
#include "lib/logger.h"
#include "lib/modelpluginselection.h"
#include "lib/modelsortplugins.h"
#include "lib/pluginsapi.h"

#ifdef PR_UNITS
#include "tests/regapitest.h"
#endif

using namespace Qt::Literals::StringLiterals;

int main(int argc, char* argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    /* --------------------------- Turning on OpenGL. --------------------------- */
    QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts);
    /* -------------------------------------------------------------------------- */
    QGuiApplication app(argc, argv);

    // Logger
    Logger::setFile(u"WinPlugins.log"_s);
    Logger::clearLogFile();
    Logger::disableFilePrint();
    Logger::disableFunctionPrint();
    qInstallMessageHandler(Logger::write);

    // Default controls style
    QQuickStyle::setStyle("Universal");
    // Credentials
    app.setOrganizationName(u"WinPlugins"_s);
    app.setApplicationName(u"WinPlugins"_s);

    QQmlApplicationEngine engine;

    Appcore appcore;
    engine.rootContext()->setContextProperty("appcore", &appcore);

    qmlRegisterUncreatableType<PluginsApi>("filetype", 1, 0, "FileType",
        "Not creatable as it is an enum type.");
    PluginsApi pluginsApi;
    engine.rootContext()->setContextProperty("pluginsApi", &pluginsApi);

    ModelPluginSelection plugins;
    plugins.updateFromFileSystem();
    //plugins.populate(5);
    ModelSortPlugins filteredPlugins;
    filteredPlugins.setSourceModel(&plugins);

    engine.rootContext()->setContextProperty("plugins", &plugins);
    engine.rootContext()->setContextProperty("filteredPlugins", &filteredPlugins);

#ifdef PR_UNITS
    QTest::qExec(new RegApiTest, argc, argv);
    return 0;
#endif

    engine.addImportPath(":/");
    const QUrl url(u"qrc:/WinPlugins/qml/main.qml"_s);
    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject* obj, const QUrl& objUrl)
        {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
