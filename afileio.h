#ifndef AFILE_H
#define AFILE_H

#include <QObject>

class AFileIO : public QObject
{
    Q_OBJECT
public:
    explicit AFileIO();
    Q_INVOKABLE QString read(QString file);
signals:

public slots:
};

#endif // AFILE_H
