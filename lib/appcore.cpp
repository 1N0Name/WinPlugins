#include "appcore.h"

Appcore::Appcore(QObject* parent)
    : QObject(parent) {}

void Appcore::setDwordValue(const QString &keyPath, const QString &valueName, DWORD value)
{
    using namespace winreg;
    try {
        // Convert QStrings to std::wstrings
        std::wstring wKeyPath = keyPath.toStdWString();
        std::wstring wValueName = valueName.toStdWString();

        // Open the key
        RegKey key{ HKEY_CURRENT_USER, wKeyPath.c_str(), KEY_WRITE };

        // Set the DWORD value
        key.SetDwordValue(wValueName.c_str(), value);
    } catch (const RegException& e) {
        // Handle error...
    }
}

DWORD Appcore::getDwordValue(const QString &keyPath, const QString &valueName)
{
    using namespace winreg;
    try {
        // Convert QStrings to std::wstrings
        std::wstring wKeyPath = keyPath.toStdWString();
        std::wstring wValueName = valueName.toStdWString();

        // Open the key
        RegKey key{ HKEY_CURRENT_USER, wKeyPath.c_str() };

        // Get the DWORD value
        return key.GetDwordValue(wValueName.c_str());
    } catch (const RegException& e) {
        // Handle error...
        return 0;
    }
}
