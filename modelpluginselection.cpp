#include "modelpluginselection.h"
#include "GlobalParameters.h"
#include <sys/types.h>
#include <sys/stat.h>
#include <direct.h>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>
#include <QFile>
#include <QDirIterator>

ModelPluginSelection::ModelPluginSelection(QObject *parent){}

QHash<int, QByteArray> ModelPluginSelection::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[NameRole] = "name";
    roles[DescriptionRole] = "description";
    roles[VersionRole] = "version";
    roles[ImgPathRole] = "imgPath";
    roles[StorePathRole] = "storePath";
    roles[SettingsPathRole] = "settingPath";
    return roles;
}

int ModelPluginSelection::rowCount(const QModelIndex &parent) const
{
    return m_plugins.size();
}

int ModelPluginSelection::columnCount(const QModelIndex &parent) const
{
    return Model_Plugins_Column_Count;
}

#if PR_DEBUG
void ModelPluginSelection::populate()
{

}
#endif

QVariant ModelPluginSelection::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();
    const Plugin &plg = m_plugins[index.row()];
    if(role == NameRole) return plg.name();
    if(role == DescriptionRole) return plg.description();
    if(role == VersionRole) return plg.version();
    if(role == ImgPathRole) return plg.imgPath();
    if(role == StorePathRole) return plg.storePath();
    if(role == SettingsPathRole) return plg.settingsPath();
    return QVariant();
}

void ModelPluginSelection::removeAt(int index)
{
    beginRemoveRows(QModelIndex(), index, index);
    m_plugins.removeAt(index);
    endRemoveRows();
    emit modelChanged();
}

void ModelPluginSelection::clear()
{
    beginResetModel();
    m_plugins.clear();
    endResetModel();
    emit modelChanged();
}

void ModelPluginSelection::add(Plugin plg)
{
    int index = m_plugins.length();
    beginInsertRows(QModelIndex(), index, index);
    m_plugins.append(plg);
    endInsertRows();
    emit modelChanged();
}

bool ModelPluginSelection::isEmpty()
{
    return m_plugins.empty();
}

[[nodiscard]]inline int dirExists(const char* const path)
{
    struct stat info;

    int statRC = stat( path, &info );
    if( statRC != 0 )
    {
        if (errno == ENOENT)  { return 0; }
        if (errno == ENOTDIR) { return 0; }
        return -1;
    }

    return ( info.st_mode & S_IFDIR ) ? 1 : 0;
}

[[nodiscard]]Plugin getPluginFromJSON(QFile& JSONfile)
{
    QString plgData;
    JSONfile.open(QIODevice::ReadOnly | QIODevice::Text);
    plgData = JSONfile.readAll();
    JSONfile.close();

    QJsonDocument plgJSON = QJsonDocument::fromJson(plgData.toUtf8());
    auto rootObj = plgJSON.object();
    auto plgObj = rootObj.value(QString("plugin")).toObject();

#if PR_DEBUG
    qDebug() << plgObj["name"].toString() ;
    qDebug() << plgObj["description"].toString();
    qDebug() << plgObj["version"].toString();
    qDebug() << plgObj["imgPath"].toString();
    qDebug() << plgObj["storePath"].toString();
    qDebug() << plgObj["settingsPath"].toString();
#endif

    return Plugin(plgObj["name"].toString(), plgObj["description"].toString(), plgObj["version"].toString(),
            plgObj["imgPath"].toString(), plgObj["storePath"].toString(), plgObj["settingsPath"].toString());
}

void ModelPluginSelection::updateFromFileSystem()
{
    if(dirExists("plugins") == 0) mkdir("plugins");

    QDirIterator it(QDir::currentPath() + "/plugins", {"*.plg"}, QDir::Files, QDirIterator::Subdirectories);

    while(it.hasNext())
    {
        QFile JSONfile(it.next());
        this->add(getPluginFromJSON(JSONfile));
    }
}

