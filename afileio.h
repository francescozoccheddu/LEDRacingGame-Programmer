#ifndef AFILE_H
#define AFILE_H

#include <QObject>

class AFileIO : public QObject
{
    Q_OBJECT
public:
    explicit AFileIO(QObject *parent = nullptr);
    Q_INVOKABLE QString read(QString file);
signals:

public slots:
};

#endif // AFILE_H
