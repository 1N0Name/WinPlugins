#ifndef REGAPI_H
#define REGAPI_H

#include <Windows.h>

class RegApi
{
public:
    static void writeKey(HKEY key);

private:
    HKEY m_Hkey;
};

#endif // REGAPI_H
