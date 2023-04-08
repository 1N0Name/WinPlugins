//#include "regapitest.h"
//#include "qforeach.h"

//QList<RegKey> bundledKeys =
//{
//    /*Some keys*/
//    RegKey(/*...*/)
//};

//void restoreRegKeys(QList<RegKey> keys)
//{
//    foreach(RegKey key, keys)
//    {
//        RegApi::writeKey(key);
//    }
//}

//void RegApiTest::regKeyReadTest()
//{
//    foreach(RegKey key, bundledKeys)
//    {
//        QCOMPARE(key, RegApi::readKey(/*...*/));
//    }
//}

//void RegApiTest::regKeyValidationTest()
//{
//    QList<RegKey> originalKeys;
//    foreach(RegKey key, bundledKeys)
//    {
//        originalKeys.append(RegApi::readKey(/*...*/));
//        RegApi::writeKey(key);
//        QCOMPARE(RegApi::readKey(/*...*/), key);
//    }
//    restoreRegKeys(originalKeys);
//}
