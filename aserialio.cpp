#include "aserialio.h"
#include <QList>
#include <QSerialPortInfo>

void ASerialIO::emitError(QSerialPort::SerialPortError code)
{
    if (code != QSerialPort::SerialPortError::NoError)
        emit error(code, serialPort.errorString());
}

ASerialIO::ASerialIO()
{
    QObject::connect(&serialPort, &QSerialPort::errorOccurred, this, &ASerialIO::emitError);
}

ASerialIO::~ASerialIO()
{
    serialPort.close();
}

void ASerialIO::refreshPortList()
{
    portList.clear();
    QList<QSerialPortInfo> portInfoList = QSerialPortInfo::availablePorts();
    for (int p = 0; p < portInfoList.length(); p++)
        portList.append(portInfoList.at(p).portName());
    emit portListChanged(getPortList());
}
