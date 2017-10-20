#include "aserialport.h"

ASerialPort::ASerialPort(QSerialPortInfo info) : info(info)
{

}

const QSerialPortInfo ASerialPort::getSerialPortInfo() const
{
    return info;
}
