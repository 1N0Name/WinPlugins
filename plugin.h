#ifndef PLUGIN_H
#define PLUGIN_H

#include "qvariant.h"
#include <QObject>

class Plugin
{
public:
    Plugin(const QString name, const QString description, const QVariant version,
           const QString imgPath, const QString storePath, const QString settingsPath);
    QString name() const {return this->m_name;};
    QString description() const {return this->m_description;};
    QVariant version() const {return this->m_version;};
    QString imgPath() const {return this->m_imgPath;};
    QString storePath() const {return this->m_storePath;};
    QString settingsPath() const {return this->m_settingsPath;};
private:
    QString m_name;
    QString m_description;
    QVariant m_version;
    QString m_imgPath;
    QString m_storePath;
    QString m_settingsPath;
};

#endif // PLUGIN_H
