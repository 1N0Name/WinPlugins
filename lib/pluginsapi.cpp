#include <stdexcept>
#include <QLoggingCategory>
#include <QFileInfo>
#include <QDebug>

#include "pluginsapi.h"

#define debug(x) qDebug() << #x << " is " << x

PluginsApi::PluginsApi(QObject *parent): QObject(parent) { }

void PluginsApi::writeKey(HKEY key)
{
    qCritical() << "Function" << __FUNCTION__ << "is not yet implemented";
}

const bool PluginsApi::checkIfExists(const QString& path, const FileType& fileType) const {
    if (fileType == FileType::FILE) {
        return QFileInfo::exists(path) && QFileInfo(path).isFile();
    } else {
        return QFileInfo::exists(path) && !QFileInfo(path).isFile();
    }
}
