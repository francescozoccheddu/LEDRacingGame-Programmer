#include "aserialio.h"
#include <QList>
#include <QSerialPortInfo>
#include <QVector>

void ASerialIO::appendFunction(QQmlListProperty<ASerialPort> *list, ASerialPort *item)
{
    QVector<ASerialPort*> *vec = reinterpret_cast<QVector<ASerialPort*>*>(list->data);
    vec->append(item);
    ASerialIO *obj = reinterpret_cast<ASerialIO*>(list->object);
    obj->portListChanged(*list);
}

int ASerialIO::countFunction(QQmlListProperty<ASerialPort> *list)
{
    QVector<ASerialPort*> *vec = reinterpret_cast<QVector<ASerialPort*>*>(list->data);
    return vec->length();
}

ASerialPort *ASerialIO::atFunction(QQmlListProperty<ASerialPort> *list, int index)
{
    QVector<ASerialPort*> *vec = reinterpret_cast<QVector<ASerialPort*>*>(list->data);
    return vec->at(index);
}

void ASerialIO::clearFunction(QQmlListProperty<ASerialPort> *list)
{
    QVector<ASerialPort*> *vec = reinterpret_cast<QVector<ASerialPort*>*>(list->data);
    for (QVector<ASerialPort*>::iterator it = vec->begin(); it != vec->end(); ++it)
        delete *it;
    vec->clear();
    ASerialIO *obj = reinterpret_cast<ASerialIO*>(list->object);
    obj->portListChanged(*list);
}

ASerialIO::ASerialIO() : portList(this, new QVector<ASerialPort*>(), appendFunction, countFunction, atFunction, clearFunction)
{
    updatePortList();
}

void ASerialIO::updatePortList()
{
    portList.clear(&portList);
    QList<QSerialPortInfo> availablePorts = QSerialPortInfo::availablePorts();
    for (QList<QSerialPortInfo>::iterator it = availablePorts.begin(); it != availablePorts.end(); ++it)
        portList.append(&portList, new ASerialPort(*it));
}

ASerialIO::~ASerialIO()
{
    QVector<ASerialPort*> *vec = reinterpret_cast<QVector<ASerialPort*>*>(portList.data);
    delete[] vec;
}
