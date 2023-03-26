#include "regkey.h"
#include <QLoggingCategory>

RegKey::RegKey()
{

}

bool RegKey::isEqual(const RegKey &key) const
{
    qCritical() << "Function" << __FUNCTION__ << "is not yet implemented";
    return true;
}

bool RegKey::operator ==(const RegKey &key) const
{
    return this->isEqual(key);
}
