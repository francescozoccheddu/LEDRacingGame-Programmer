#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "afileio.h"
#include "aserialio.h"
#include "aserialport.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    qmlRegisterUncreatableType<ASerialPort>("ASerialPort", 1,0, "ASerialPort", "Cannot instantiate ASerialPort objects");

    QQmlApplicationEngine engine;
    QQmlContext* ctx{engine.rootContext()};

    AFileIO *fileIO = new AFileIO();
    ASerialIO *serialIO = new ASerialIO();
    ctx->setContextProperty("fileIO", fileIO);
    ctx->setContextProperty("serialIO", serialIO);

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
