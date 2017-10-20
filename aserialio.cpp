#include "aserialio.h"
#include <QList>
#include <QSerialPortInfo>
#include <QVector>



int ASerialIO::countFunction(QQmlListProperty<ASerialPort> *list)
{
    return reinterpret_cast<ASerialIO*>(list->object)->portCount;
}

ASerialPort *ASerialIO::atFunction(QQmlListProperty<ASerialPort> *list, int index)
{
    return reinterpret_cast<ASerialIO*>(list->object)->portList[index];
}

void ASerialIO::clearPorts()
{
    for (int p = 0; p < portCount; p++)
        delete portList[p];
    if (portList != Q_NULLPTR)
        delete[] portList;
    portList = Q_NULLPTR;
    portCount = 0;
}

ASerialIO::ASerialIO() : portList(Q_NULLPTR), portCount(0)
{
}

void ASerialIO::updatePortList()
{
    clearPorts();
    QList<QSerialPortInfo> portInfoList = QSerialPortInfo::availablePorts();
    portCount = portInfoList.length();
    if (portCount > 0){
        portList = new ASerialPort*[portCount];
        for (int p = 0; p < portCount; p++)
            portList[p] = new ASerialPort(portInfoList[p]);
    }
    emit portListChanged(getPortList());
}

ASerialIO::~ASerialIO()
{
    clearPorts();
}
