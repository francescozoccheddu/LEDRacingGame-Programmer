#include "afileio.h"
#include <QFile>

AFileIO::AFileIO()
{

}

QString AFileIO::read(QString filename)
{
    QFile file(filename);
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    QString content = file.readAll();
    file.close();
    return content;
}
