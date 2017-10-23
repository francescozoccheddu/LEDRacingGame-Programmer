#include "aserialio.h"
#include <QList>
#include <QSerialPortInfo>

#include <QDebug>

void ASerialIO::parseError(QSerialPort::SerialPortError code)
{
    if (code != QSerialPort::SerialPortError::NoError)
        emit error(QString("Error code %1").arg(serialPort.error()), serialPort.errorString());
}

void ASerialIO::readyToRead()
{
    char data;
    qint64 size = serialPort.bytesAvailable();
    qint64 res = serialPort.read(&data, size);
    if (res == size && res > 0)
        emit incoming(data);
    else
        emit error("Read error", QString("Read returned %1 (%2 bytes available)").arg(res,size));
}

ASerialIO::ASerialIO()
{
    QObject::connect(&serialPort, &QSerialPort::errorOccurred, this, &ASerialIO::parseError);
    QObject::connect(&serialPort, &QSerialPort::readyRead, this, &ASerialIO::readyToRead);
}

ASerialIO::~ASerialIO()
{
    if (serialPort.isOpen())
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

void ASerialIO::write(int data)
{
    char charData = data;
    qint64 res = serialPort.write(&charData, 1);
    if (res != 1)
        emit error("Write error", QString("Write returned %1").arg(res));
}
