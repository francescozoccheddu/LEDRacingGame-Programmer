#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QVariantMap>
#include "parameterdataobject.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);


    QQmlApplicationEngine engine;
    QQmlContext* ctx{engine.rootContext()};

    QList<QObject*> dataList;
    dataList.append(new ParameterDataObject("Item 1", "red"));
    dataList.append(new ParameterDataObject("Item 2", "green"));
    dataList.append(new ParameterDataObject("Item 3", "blue"));
    dataList.append(new ParameterDataObject("Item 4", "yellow"));

    ctx->setContextProperty("parameterDataModel", QVariant::fromValue(dataList));
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;



    return app.exec();
}
