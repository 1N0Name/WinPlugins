#ifndef LOGGER_H
#define LOGGER_H

#include <QDebug>
#include <QFile>
#include <QHash>

#define LOGD(...) qDebug() << __VA_ARGS__
#define LOGI(...) qInfo() << __VA_ARGS__
#define LOGW(...) qWarning() << __VA_ARGS__
#define LOGC(...) qCritical() << __VA_ARGS__
#define LOGF(...) qFatal() << __VA_ARGS__

namespace Logger
{
    void write(QtMsgType, const QMessageLogContext&, const QString&);

    void setFile(const QString&);

    void clearLogFile();

    void enableTimeStamp();
    void disableTimeStamp();
    void enableHeader();
    void disableHeader();
    void enableFilePrint();
    void disableFilePrint();
    void enableFunctionPrint();
    void disableFunctionPrint();
} // namespace Logger

#endif // LOGGER_H
