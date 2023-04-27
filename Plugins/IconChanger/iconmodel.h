#ifndef ICONMODEL_H
#define ICONMODEL_H

#include <QAbstractListModel>
#include <QDir>
#include <QFileInfoList>
#include <QtQmlIntegration>

class IconModel : public QAbstractListModel
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit IconModel(QObject* parent = nullptr);

    enum Roles
    {
        IconRole = Qt::UserRole + 1,
        NameRole
    };

    int rowCount(const QModelIndex& parent = QModelIndex()) const override;
    QVariant data(const QModelIndex& index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

private:
    QList<QString> m_icons;
};

#endif // ICONMODEL_H
