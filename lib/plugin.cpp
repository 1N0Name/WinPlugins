#include "plugin.h"

Plugin::Plugin(const QString &name, const QString &description, const QVariant &version,
               const QString &imgPath, const QString &storePath, const QString &settingsPath,
               const double &price, const QString &category)
{
    m_name            = name;
    m_description     = description;
    m_version         = version;
    m_imgPath         = imgPath;
    m_storePath       = storePath;
    m_settingsPath    = settingsPath;
    m_price           = price;
    m_category        = category;
}
