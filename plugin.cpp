#include "plugin.h"

Plugin::Plugin(const QString name, const QString description, const QVariant version,
               const QString imgPath, const QString storePath, const QString settingsPath)
{
    this->m_name            = name;
    this->m_description     = description;
    this->m_version         = version;
    this->m_imgPath         = imgPath;
    this->m_storePath       = storePath;
    this->m_settingsPath    = settingsPath;
}
