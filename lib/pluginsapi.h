#ifndef REGAPI_H
#define REGAPI_H

#include <Windows.h>
#include <QObject>

class PluginsApi : public QObject
{
    Q_OBJECT
public:
    enum FileType
    {
        FILE,
        FOLDER
    };
    Q_ENUM(FileType)

    Q_INVOKABLE const bool checkIfExists(const QString&, const FileType&) const;

    explicit PluginsApi(QObject * parent = nullptr);

    static void writeKey(HKEY key);

private:
    HKEY m_Hkey;
};

#endif // REGAPI_H
