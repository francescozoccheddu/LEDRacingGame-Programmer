#include "aserialio.h"
#include <QList>
#include <QSerialPortInfo>

#include <QDebug>

void ASerialIO::emitError(QSerialPort::SerialPortError code)
{
    if (code != QSerialPort::SerialPortError::NoError)
        emit error("Error code" + serialPort.error(), serialPort.errorString());
}

void ASerialIO::readyToRead()
{
    qint64 size = serialPort.bytesAvailable();
    while (size-- > 0){
        char data;
        qint64 res = serialPort.read(&data, 1);
        if (data == 1)
            processIncoming(data);
    }
}

void ASerialIO::processIncoming(char data)
{
    if (busy) {

    }
    else
        emit error("Unexpected incoming data");
}

ASerialIO::ASerialIO()
{
    QObject::connect(&serialPort, &QSerialPort::errorOccurred, this, &ASerialIO::emitError);
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

void ASerialIO::write(int address, QList<int> bytes)
{
    if (busy) {
        emit error("Serial port busy", "Pending read or write operation");
        return;
    }
    dataBytes = bytes;
    dataCounter = 0;
    writing = true;
}

void ASerialIO::read(int address, int byteCount)
{
    if (busy) {
        emit error("Serial port busy", "Pending read or write operation");
        return;
    }
    if (waiting) {
        emit error("Serial port not initialized", "Start message not received");
        return;
    }
}
