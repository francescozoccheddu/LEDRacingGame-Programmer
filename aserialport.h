#ifndef ASERIALPORTLIST_H
#define ASERIALPORTLIST_H

#include <QObject>
#include <QSerialPortInfo>

class ASerialPort : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ getName NOTIFY portChanged)
    Q_PROPERTY(QString location READ getLocation NOTIFY portChanged)
    Q_PROPERTY(QString description READ getDescription NOTIFY portChanged)

    const QSerialPortInfo info;

public:
    ASerialPort(const QSerialPortInfo info);

    const QSerialPortInfo getSerialPortInfo() const;

    void setSerialPortInfo(const QSerialPortInfo &value);

    QString getName() const
    {
        return info.portName();
    }

    QString getLocation() const
    {
        return info.systemLocation();
    }

    QString getDescription() const
    {
        return info.description();
    }

signals:

    void portChanged(QString location);

public slots:
};

#endif // ASERIALPORTLIST_H
