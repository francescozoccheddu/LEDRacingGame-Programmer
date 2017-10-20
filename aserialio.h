#ifndef ASERIALIO_H
#define ASERIALIO_H

#include <QObject>
#include <QQmlListProperty>
#include "aserialport.h"

class ASerialIO : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<ASerialPort> portList READ getPortList NOTIFY portListChanged)
    QQmlListProperty<ASerialPort> portList;

    static void appendFunction(QQmlListProperty<ASerialPort> * list, ASerialPort * item);
    static int countFunction(QQmlListProperty<ASerialPort> * list);
    static ASerialPort * atFunction(QQmlListProperty<ASerialPort> * list, int index);
    static void clearFunction(QQmlListProperty<ASerialPort> * list);

public:
    explicit ASerialIO();
    Q_INVOKABLE void updatePortList();
    virtual ~ASerialIO();

QQmlListProperty<ASerialPort> getPortList() const
{
    return portList;
}

signals:

void portListChanged(QQmlListProperty<ASerialPort> portList);

public slots:
};

#endif // ASERIALIO_H
