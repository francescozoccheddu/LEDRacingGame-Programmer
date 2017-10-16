#ifndef PARAMETERDATAOBJECT_H
#define PARAMETERDATAOBJECT_H

#include <QObject>

class ParameterDataObject : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString description READ description WRITE setDescription NOTIFY descriptionChanged)

    QString m_description;
    QString m_name;

public:
    explicit ParameterDataObject(QObject *parent = nullptr);
    ParameterDataObject(QString name, QString description);

QString description() const
{
    return m_description;
}

QString name() const
{
    return m_name;
}

signals:

void descriptionChanged(QString description);

void nameChanged(QString name);

public slots:
void setDescription(QString description)
{
    if (m_description == description)
        return;

    m_description = description;
    emit descriptionChanged(m_description);
}
void setName(QString name)
{
    if (m_name == name)
        return;

    m_name = name;
    emit nameChanged(m_name);
}
};

#endif // PARAMETERDATAOBJECT_H
