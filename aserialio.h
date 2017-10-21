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
    Q_PROPERTY(qreal progress READ getProgress NOTIFY progressChanged)
    Q_PROPERTY(bool busy READ isBusy NOTIFY busyChanged)

    QStringList portList;
    QSerialPort serialPort;

    QList<int> dataBytes;
    int dataCounter;
    bool writing;
    bool busy;

private slots:
    void emitError(QSerialPort::SerialPortError code);

    void readyToRead();

    void processIncoming(char data);

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

    qreal getProgress() const
    {
        if (writing)
            return dataCounter / (float) dataBytes.length();
        else
            return dataBytes.length() / (float) dataCounter;
    }

    bool isBusy() const
    {
        return busy;
    }

    Q_INVOKABLE void refreshPortList();

    Q_INVOKABLE void write(int address, QList<int> bytes);

    Q_INVOKABLE void read(int address, int byteCount);

signals:

    void portChanged(QString port);

    void portListChanged(QStringList portList);

    void connectedChanged(bool connected);

    void openChanged(bool open);

    void progressChanged(qreal progress);

    void busyChanged(bool busy);

    void error(QString message, QString messageExt = QString());

    void readCompleted(QList<int> bytes);

public slots:
void setPort(QString _port)
{
    if (_port == getPort())
        return;
    serialPort.setPortName(_port);
    emit portChanged(getPort());
}

void setOpen(bool _opened)
{
    if (_opened == isOpen())
        return;
    if (_opened) {
        busy = true;
        dataCounter = 0;
        dataBytes.clear();
        emit busyChanged(isBusy());
        serialPort.open(QSerialPort::ReadWrite);
    }
    else
        serialPort.close();
    emit openChanged(isOpen());
}

};

#endif // ASERIALIO_H
