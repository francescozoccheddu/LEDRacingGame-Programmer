#ifndef ASERIALPORTLIST_H
#define ASERIALPORTLIST_H

#include <QObject>
#include <QSerialPortInfo>

class ASerialPort : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ getName)
    Q_PROPERTY(QString location READ getLocation)
    Q_PROPERTY(QString description READ getDescription)

    QSerialPortInfo info;

public:
    ASerialPort(QSerialPortInfo info);

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

public slots:
};

#endif // ASERIALPORTLIST_H
