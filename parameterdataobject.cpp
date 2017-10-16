#include "parameterdataobject.h"

ParameterDataObject::ParameterDataObject(QObject *parent) : QObject(parent)
{

}

ParameterDataObject::ParameterDataObject(QString name, QString description)
{
    setName(name);
    setDescription(description);
}
