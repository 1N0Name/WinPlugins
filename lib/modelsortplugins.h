#ifndef MODELSORTPLUGINS_H
#define MODELSORTPLUGINS_H

#include <QObject>
#include <QSortFilterProxyModel>
#include <regex>

class ModelSortPlugins : public QSortFilterProxyModel
{
    Q_OBJECT
    Q_PROPERTY(QString nameFilter READ nameFilter WRITE setNameFilter NOTIFY filterChanged)
    Q_PROPERTY(QString categoryFilter READ categoryFilter WRITE setCategoryFilter NOTIFY filterChanged)
    // Q_PROPERTY(QString priceFilter READ priceFilter WRITE setPriceFilter NOTIFY filterChanged)

public:
    explicit ModelSortPlugins(QObject* parent = nullptr)
        : QSortFilterProxyModel(parent) {};

    QString nameFilter() const
    {
        return nameRegExp.pattern();
    }

    QString categoryFilter() const
    {
        return categoryRegExp.pattern();
    }

    void setNameFilter(const QString& text)
    {
        nameRegExp = (QRegularExpression(text, QRegularExpression::CaseInsensitiveOption));
        updateFilter();
    }

    void setCategoryFilter(const QString& text)
    {
        categoryRegExp = (QRegularExpression(text, QRegularExpression::CaseInsensitiveOption));
        updateFilter();
    }

signals:
    void filterChanged();

protected:
    bool filterAcceptsRow(int, const QModelIndex&) const override;

private:
    QRegularExpression nameRegExp;
    QRegularExpression categoryRegExp;
    void updateFilter();
};

#endif // MODELSORTPLUGINS_H
