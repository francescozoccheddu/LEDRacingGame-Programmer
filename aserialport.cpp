#include "aserialport.h"

ASerialPort::ASerialPort(const QSerialPortInfo info) : info(info)
{

}

const QSerialPortInfo ASerialPort::getSerialPortInfo() const
{
    return info;
}
