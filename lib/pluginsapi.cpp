#include <QDebug>
#include <QFileInfo>
#include <QLoggingCategory>
#include <stdexcept>

#include "pluginsapi.h"

PluginsApi::PluginsApi(QObject* parent)
    : QObject(parent) {}

void PluginsApi::writeKey(HKEY key)
{
    qCritical() << "Function" << __FUNCTION__ << "is not yet implemented";
}

bool PluginsApi::checkIfExists(const QString& path, const FileType& fileType)
{
    if (fileType == FileType::FILE)
        return QFileInfo::exists(path) && QFileInfo(path).isFile();
    else
        return QFileInfo::exists(path) && !QFileInfo(path).isFile();
}
