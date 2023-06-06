#ifndef APPCORE_H
#define APPCORE_H

#include <QObject>
#include <QString>
#include "WinReg.hpp"

class Appcore : public QObject
{
    Q_OBJECT
public:
    explicit Appcore(QObject* parent = nullptr);
    Q_INVOKABLE void setDwordValue(const QString& keyPath, const QString& valueName, DWORD value);

    Q_INVOKABLE DWORD getDwordValue(const QString& keyPath, const QString& valueName);
};

#endif // APPCORE_H
