#ifndef REGAPI_H
#define REGAPI_H

#include <regkey.h>

class RegApi
{
public:
    static RegKey readKey();
    static void writeKey(RegKey key);
};

#endif // REGAPI_H
