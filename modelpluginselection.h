#ifndef MODELPLUGINSELECTION_H
#define MODELPLUGINSELECTION_H

#define Model_Plugins_Column_Count 6

#include "plugin.h"
#include <QAbstractItemModel>
#include <GlobalParameters.h>

class ModelPluginSelection : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit ModelPluginSelection(QObject *parent = nullptr);
    enum PluginRoles
    {
        NameRole = Qt::UserRole + 1,
        DescriptionRole,
        VersionRole,
        ImgPathRole,
        StorePathRole,
        SettingsPathRole
    };

    /* ------------------------ Q_INVOKABLES ------------------------ */
    Q_INVOKABLE int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    Q_INVOKABLE void removeAt(int index);
    Q_INVOKABLE void clear();
    Q_INVOKABLE void add(Plugin plg);
    Q_INVOKABLE bool isEmpty();
    Q_INVOKABLE void updateFromFileSystem();
    /* ------------------------ QAbstractListModel Methods ------------------------ */
    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex &index, int role) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;
#if PR_DEBUG
    void populate();
#endif
private:
    QList<Plugin> m_plugins;
signals:
    void modelChanged();
};

#endif // MODELPLUGINSELECTION_H
