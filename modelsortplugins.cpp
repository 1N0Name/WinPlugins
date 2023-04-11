#include "modelsortplugins.h"
#include "modelpluginselection.h"

bool ModelSortPlugins::filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const
{
    QModelIndex index = sourceModel()->index(sourceRow, 0, sourceParent);

#if 0
    qDebug() << sourceModel()->data(index, ModelPluginSelection::NameRole).toString();
    qDebug() << sourceModel()->data(index, ModelPluginSelection::CategoryRole).toString();
    qDebug() << sourceModel()->data(index, ModelPluginSelection::PriceRole).toDouble();
#endif

    QString name = sourceModel()->data(index, ModelPluginSelection::NameRole).toString();
    QString category = sourceModel()->data(index, ModelPluginSelection::CategoryRole).toString();

    return name.contains(nameRegExp) && category.contains(categoryRegExp);
}

void ModelSortPlugins::updateFilter()
{
    invalidateFilter();
    emit filterChanged();
}
