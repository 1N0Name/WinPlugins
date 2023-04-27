#include "modelsortplugins.h"
#include "modelpluginselection.h"

bool ModelSortPlugins::filterAcceptsRow(int sourceRow, const QModelIndex& sourceParent) const
{
    QModelIndex index = sourceModel()->index(sourceRow, 0, sourceParent);
    QString name      = sourceModel()->data(index, ModelPluginSelection::NameRole).toString();
    QString category  = sourceModel()->data(index, ModelPluginSelection::CategoryRole).toString();

    return name.contains(nameRegExp) && category.contains(categoryRegExp);
}

void ModelSortPlugins::updateFilter()
{
    invalidateFilter();
    emit filterChanged();
}
