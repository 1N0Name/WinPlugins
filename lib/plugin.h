#ifndef PLUGIN_H
#define PLUGIN_H

#include <QObject>
#include <QVariant>

class Plugin
{
public:
    Plugin(const QString& name, const QString& description,
        const QVariant& version, const QString& imgPath,
        const QString& storePath, const QString& settingsPath,
        const double& price, const QString& category);

    QString getName() const { return m_name; };
    QString getDescription() const { return m_description; };
    QVariant getVersion() const { return m_version; };
    QString getImgPath() const { return m_imgPath; };
    QString getStorePath() const { return m_storePath; };
    QString getSettingsPath() const { return m_settingsPath; };
    double getPrice() const { return m_price; };
    QString getCategory() const { return m_category; };

private:
    QString m_name;
    QString m_description;
    QVariant m_version;
    QString m_imgPath;
    QString m_storePath;
    QString m_settingsPath;
    double m_price;
    QString m_category;
};

#endif // PLUGIN_H
