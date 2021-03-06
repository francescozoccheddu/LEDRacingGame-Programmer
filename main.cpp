#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "afileio.h"
#include "aserialio.h"

int main(int argc, char *argv[])
{

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QQmlContext* ctx{engine.rootContext()};

    AFileIO fileIO;
    ASerialIO serialIO;
    ctx->setContextProperty("fileIO", &fileIO);
    ctx->setContextProperty("serialIO", &serialIO);
#ifdef Q_OS_ANDROID
    ctx->setContextProperty("isAndroid", QVariant(true));
#else
    ctx->setContextProperty("isAndroid", QVariant(false));
#endif
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
