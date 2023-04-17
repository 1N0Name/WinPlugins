#include <sys/types.h>
#include <sys/stat.h>
#include <direct.h>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>
#include <QFile>
#include <QDirIterator>

#include "modelpluginselection.h"

ModelPluginSelection::ModelPluginSelection(QObject *parent){}

QHash<int, QByteArray> ModelPluginSelection::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[NameRole]         = "name";
    roles[DescriptionRole]  = "description";
    roles[VersionRole]      = "version";
    roles[ImgPathRole]      = "imgPath";
    roles[StorePathRole]    = "storePath";
    roles[SettingsPathRole] = "settingsPath";
    roles[PriceRole]        = "price";
    roles[CategoryRole]     = "category";
    return roles;
}

int ModelPluginSelection::rowCount(const QModelIndex &parent) const
{
    return m_plugins.size();
}

int ModelPluginSelection::columnCount(const QModelIndex &parent) const
{
    return MODEL_PLUGINS_COLUMN_COUNT;
}

QVariant ModelPluginSelection::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    const Plugin &plg = m_plugins[index.row()];
    if(role == NameRole)
        return plg.getName();
    if(role == DescriptionRole)
        return plg.getDescription();
    if(role == VersionRole)
        return plg.getVersion();
    if(role == ImgPathRole)
        return plg.getImgPath();
    if(role == StorePathRole)
        return plg.getStorePath();
    if(role == SettingsPathRole)
        return plg.getSettingsPath();
    if(role == PriceRole)
        return plg.getPrice();
    if(role == CategoryRole)
        return plg.getCategory();

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

void ModelPluginSelection::append(Plugin plg)
{
    int index = m_plugins.length();
    beginInsertRows(QModelIndex(), index, index);
    m_plugins.append(plg);
    endInsertRows();
    emit modelChanged();
}

bool ModelPluginSelection::isEmpty() const
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

    QFileInfo JSONinfo(JSONfile);
    QString settingsPath = "file:///" + JSONinfo.absolutePath() + "/" + plgObj["settingsPath"].toString();

#ifdef PR_DEBUG
    qDebug() << "/ --------------------------------- Plugin --------------------------------- /";
    qDebug() << "Plugin Title:\t" << plgObj["name"].toString();
    qDebug() << "Description:\t" << plgObj["description"].toString();
    qDebug() << "Version:\t\t" << plgObj["version"].toString();
    qDebug() << "Image Preview Path:\t" << plgObj["imgPath"].toString();
    qDebug() << "Preview Page Path:\t" << plgObj["storePath"].toString();
    qDebug() << "Settings Page Path:\t" << settingsPath;
    qDebug() << "Plugin Price:\t" << plgObj["price"].toDouble();
    qDebug() << "Plugin Category:\t" << plgObj["category"].toString();
    qDebug() << "/ -------------------------------------------------------------------------- /\n";
#endif

    return Plugin(plgObj["name"].toString(), plgObj["description"].toString(), plgObj["version"].toString(),
                  plgObj["imgPath"].toString(), plgObj["storePath"].toString(), settingsPath,
                  plgObj["price"].toDouble(), plgObj["category"].toString());
}

void ModelPluginSelection::updateFromFileSystem()
{
    this->clear();
    // TODO: Do we even need this check?
    if(dirExists("plugins") == 0)
        _mkdir("plugins");

    QDirIterator it(QDir::currentPath() + "/plugins", {"*.plg"}, QDir::Files, QDirIterator::Subdirectories);

    while(it.hasNext())
    {
        QFile JSONfile(it.next());
        this->append(getPluginFromJSON(JSONfile));
    }
}

QList<Plugin> ModelPluginSelection::getPlugins()
{
    return m_plugins;
}

#ifdef PR_DEBUG
void ModelPluginSelection::populate(int repeats)
{
    for(int i = 0 ; i < repeats; i++)
    {
        QDirIterator it(QDir::currentPath() + "/plugins", {"*.plg"}, QDir::Files, QDirIterator::Subdirectories);

        while(it.hasNext())
        {
            QFile JSONfile(it.next());
            this->append(getPluginFromJSON(JSONfile));
        }
    }
}
#endif

