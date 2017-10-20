#ifndef ASERIALIO_H
#define ASERIALIO_H

#include <QObject>
#include <QQmlListProperty>
#include "aserialport.h"

class ASerialIO : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<ASerialPort> portList READ getPortList NOTIFY portListChanged)

    static int countFunction(QQmlListProperty<ASerialPort> * list);
    static ASerialPort * atFunction(QQmlListProperty<ASerialPort> * list, int index);
    void clearPorts();

    ASerialPort **portList;
    int portCount;

public:
    explicit ASerialIO();
    Q_INVOKABLE void updatePortList();
    virtual ~ASerialIO();

QQmlListProperty<ASerialPort> getPortList()
{
    return QQmlListProperty<ASerialPort>(this, Q_NULLPTR, countFunction, atFunction);
}

signals:

void portListChanged(QQmlListProperty<ASerialPort> portList);

public slots:
};

#endif // ASERIALIO_H
