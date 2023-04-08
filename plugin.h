#ifndef PLUGIN_H
#define PLUGIN_H

#include <QObject>

#include "qvariant.h"

class Plugin
{
public:
    Plugin(const QString name, const QString description, const QVariant version,
           const QString imgPath, const QString storePath, const QString settingsPath);
    QString name() const { return m_name; };
    QString description() const { return m_description; };
    QVariant version() const { return m_version; };
    QString imgPath() const { return m_imgPath; };
    QString storePath() const { return m_storePath; };
    QString settingsPath() const { return m_settingsPath; };
private:
    QString m_name;
    QString m_description;
    QVariant m_version;
    QString m_imgPath;
    QString m_storePath;
    QString m_settingsPath;
};

#endif // PLUGIN_H
