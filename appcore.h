#ifndef APPCORE_H
#define APPCORE_H

#include <QObject>
#include <GlobalParameters.h>

class Appcore : public QObject
{
    Q_OBJECT
public:
    explicit Appcore(QObject * parent = nullptr);
};

#endif // APPCORE_H