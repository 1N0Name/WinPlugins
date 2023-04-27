#include "Windows.h"
#include <QImage>

#include "iconmodel.h"

IconModel::IconModel(QObject* parent)
{

    QDir dir(QDir::currentPath() + "/plugins/IconChanger/IconRepository");
    QStringList filters;
    filters << "*.png"
            << "*.ico";
    QFileInfoList files = dir.entryInfoList(filters);
    for (const auto& file : files)
        m_icons.append("file:///" + file.absoluteFilePath());
}

int IconModel::rowCount(const QModelIndex& parent) const
{
    if (parent.isValid())
        return 0;

    return m_icons.count();
}

QVariant IconModel::data(const QModelIndex& index, int role) const
{
    if (!index.isValid())
        return QVariant();

    switch (role) {
        case IconRole:
            return m_icons.at(index.row());
            break;
        case NameRole:
            return "Icon " + QString::number(index.row() + 1);
            break;
        default:
            break;
    }

    return QVariant();
}

QHash<int, QByteArray> IconModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[IconRole] = "icon";
    roles[NameRole] = "name";
    return roles;
}
