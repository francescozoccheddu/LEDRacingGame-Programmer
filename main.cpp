#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QVariantMap>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QDebug>
#include <QFile>
#include "parameterdataobject.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);


    QQmlApplicationEngine engine;
    QQmlContext* ctx{engine.rootContext()};

    QString val;
    QFile file;
    file.setFileName("C:/Users/zocch/Desktop/test.json");
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    val = file.readAll();
    file.close();
    QJsonDocument doc = QJsonDocument::fromJson(val.toUtf8());
    QJsonObject root = doc.object();
    QJsonArray list = root["list"].toArray();

    QList<QObject*> dataList;
    for (QJsonValueRef objRef : list) {
        QJsonObject o = objRef.toObject();
        QString name = o["name"].toString();
        QString description = o["description"].toString();
        dataList.append(new ParameterDataObject(name, description));
    }

    ctx->setContextProperty("parameterDataModel", QVariant::fromValue(dataList));
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;



    return app.exec();
}
