#ifndef ASERIALIO_H
#define ASERIALIO_H

#include <QObject>
#include <QSerialPort>
#include <QQmlListProperty>

class ASerialIO : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString port READ getPort WRITE setPort NOTIFY portChanged)
    Q_PROPERTY(QStringList portList READ getPortList NOTIFY portListChanged)
    Q_PROPERTY(bool open READ isOpen WRITE setOpen NOTIFY openChanged)

    QStringList portList;
    QSerialPort serialPort;

private slots:
    void parseError(QSerialPort::SerialPortError code);

    void readyToRead();

public:
    ASerialIO();
    virtual ~ASerialIO();

    QString getPort() const
    {
        return serialPort.portName();
    }

    QStringList getPortList() const
    {
        return portList;
    }

    bool isOpen() const
    {
        return serialPort.isOpen();
    }

    Q_INVOKABLE void refreshPortList();

    Q_INVOKABLE void write(int data);

    Q_INVOKABLE QString describe(QString port);

signals:

    void portChanged(QString port);

    void portListChanged(QStringList portList);

    void openChanged(bool open);

    void error(QString message, QString messageExt = QString());

    void incoming(int data);

public slots:
void setPort(QString _port) {
    if (_port == getPort())
        return;
    serialPort.setPortName(_port);
    emit portChanged(getPort());
}

void setOpen(bool _opened) {
    if (_opened == isOpen())
        return;
    if (_opened)
        serialPort.open(QSerialPort::ReadWrite);
    else
        serialPort.close();
    emit openChanged(isOpen());
}

};

#endif // ASERIALIO_H
