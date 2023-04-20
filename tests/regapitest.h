#ifndef REGAPITEST_H
#define REGAPITEST_H

#ifdef PR_UNITS
    #include <QObject>
    #include <QTest>

    #include "pluginscore.h"

    class RegApiTest : public QObject
    {
        Q_OBJECT
    private slots:
        /* ------------------------ Unit tests ------------------------ */
        void regKeyReadTest();
        /* ------------------------ Integration tests ------------------------ */
        void regKeyValidationTest();
    };
    #endif
#endif // REGAPITEST_H
