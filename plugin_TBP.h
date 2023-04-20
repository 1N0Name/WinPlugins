#ifndef PLUGIN_TBP_H
#define PLUGIN_TBP_H

#include <Windows.h>
#include <QObject>

class TaskBarPlugin : public QObject
{
    Q_OBJECT
public:
    void writePosition(int position);
};

#endif // PLUGIN_TBP_H
