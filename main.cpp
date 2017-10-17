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
#include "afileio.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QQmlContext* ctx{engine.rootContext()};

    AFileIO *fileIO = new AFileIO();
    ctx->setContextProperty("fileIO", fileIO);

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
