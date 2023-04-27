#include <iostream>
#include <QDateTime>
#include <QFile>
#include <QHash>
#include <QTextStream>

namespace
{
    enum Target : short
    {
        DISABLED = 1,
        CONSOLE  = 2,
        LOG_FILE = 4
    } m_logTarget = Target::LOG_FILE;

    QHash<QtMsgType, QString> m_contextNames = {
        {QtMsgType::QtDebugMsg,     QString::fromUtf8("\xf0\x9f\x9f\xa3")},
        { QtMsgType::QtInfoMsg,     QString::fromUtf8("\xf0\x9f\x9f\xa2")},
        { QtMsgType::QtWarningMsg,  QString::fromUtf8("\xf0\x9f\x9f\xa1")},
        { QtMsgType::QtCriticalMsg, QString::fromUtf8("\xf0\x9f\x9f\xa0")},
        { QtMsgType::QtFatalMsg,    QString::fromUtf8("\xf0\x9f\x94\xb4")}
    };

    QFile* m_logFile        = Q_NULLPTR;
    bool m_addTimestamp     = true;
    bool m_addHeader        = true;
    bool m_addFilePrint     = true;
    bool m_addFunctionPrint = true;

    void closeLogFile()
    {
        if (m_logFile != Q_NULLPTR) {
            m_logFile->close();
            delete m_logFile;
        }
    }
} // namespace

namespace Logger
{
    void write(QtMsgType type, const QMessageLogContext& context, const QString& msg)
    {
        // Log::Target::DISABLED takes precedency of all over possible targets.
        if ((m_logTarget & Target::DISABLED) == Target::DISABLED)
            return;

        QString out;

        if (m_addTimestamp)
            out.append(QString::fromUtf8("\xE2\x8C\x9B") + "[" + QDateTime::currentDateTime().toString("dd-MM | hh:mm:ss") + "]");

        if (m_addHeader)
            out.append(" | " + m_contextNames.value(type));

        if (m_addFilePrint)
            out.append(" | " + QString::fromUtf8("\xF0\x9F\x97\x83\xEF\xB8\x8F") + QString(context.file).section('\\', -1) + "(" + QString::number(context.line) + ")");

        if (m_addFunctionPrint)
            out.append(" | " + QString(context.function).section('(', -2, -2).section(' ', -1).section(':', -1));

        out.append(" | " + msg + "\n");

        //        if ((m_logTarget & Target::CONSOLE) == Target::CONSOLE)
        //            std::cerr << out.toStdString();

        if ((m_logTarget & Target::LOG_FILE) == Target::LOG_FILE && m_logFile->isOpen()) {
            m_logFile->write(out.toUtf8());
            m_logFile->flush();
        }
    };

    void setFile(const QString& filename)
    {
        closeLogFile();

        m_logFile = new QFile;
        m_logFile->setFileName(filename);
        m_logFile->open(QFile::WriteOnly | QFile::Append);
    }

    void clearLogFile()
    {
        if (m_logFile != Q_NULLPTR)
            m_logFile->resize(0);
    }

    void enableTimeStamp() { m_addTimestamp = true; }

    void disableTimeStamp() { m_addTimestamp = false; }

    void enableHeader() { m_addHeader = true; }

    void disableHeader() { m_addHeader = false; }

    void enableFilePrint() { m_addFilePrint = true; }

    void disableFilePrint() { m_addFilePrint = false; }

    void enableFunctionPrint() { m_addFunctionPrint = true; }

    void disableFunctionPrint() { m_addFunctionPrint = false; }
} // namespace Logger
