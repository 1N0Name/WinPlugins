#ifndef REGAPI_H
#define REGAPI_H

#include <QObject>
#include <Windows.h>

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

    Q_INVOKABLE static bool checkIfExists(const QString&, const FileType&);

    explicit PluginsApi(QObject* parent = nullptr);

    static void writeKey(HKEY key);
};

#endif // REGAPI_H
