#ifndef REGAPITEST_H
#define REGAPITEST_H

#include <QObject>
#include <QTest>
#include <regapi.h>

class RegApiTest : public QObject
{
    Q_OBJECT
private slots:
    /* ------------------------ Unit tests ------------------------ */
    void regKeyReadTest();
    /* ------------------------ Integration tests ------------------------ */
    void regKeyValidationTest();
};

#endif // REGAPITEST_H
