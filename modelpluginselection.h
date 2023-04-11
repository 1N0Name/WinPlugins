#ifndef MODELPLUGINSELECTION_H
#define MODELPLUGINSELECTION_H

#define MODEL_PLUGINS_COLUMN_COUNT 6

#include <QAbstractItemModel>

#include "plugin.h"

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
        SettingsPathRole,
        PriceRole,
        CategoryRole
    };

    /* ------------------------ Q_INVOKABLES ------------------------ */
    /*Return the number of rows in model*/
    Q_INVOKABLE int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    /*Removes plugin at position <index>*/
    Q_INVOKABLE void removeAt(int);
    /*Removes all plugins from model*/
    Q_INVOKABLE void clear();
    /*Appends plugin <plg> to model*/
    Q_INVOKABLE void append(Plugin);
    /*Returns true if model is empty, else returns false*/
    Q_INVOKABLE bool isEmpty() const;
    /*Updates model from *.plg files in folder named <plugins>*/
    Q_INVOKABLE void updateFromFileSystem();
    /*Returns <m_plugins> as a value*/
    Q_INVOKABLE QList<Plugin> getPlugins();
    /* ------------------------ QAbstractListModel Methods ------------------------ */
    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex &, int) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;
#ifdef PR_DEBUG
    void populate(int repeats);
#endif

private:
    QList<Plugin> m_plugins;

signals:
    void modelChanged();
};

#endif // MODELPLUGINSELECTION_H
