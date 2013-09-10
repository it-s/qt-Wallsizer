#include "droparea.h"
#include "mythread.h"
#include "resolutionmodel.h"
#include "dirmodel.h"
#include <QSize>
#include <QtQuick/QQuickView>
#include <QGuiApplication>
#include <QQuickView>
#include <QApplication>
#include <QQmlContext>
#include <QQmlApplicationEngine>
int main(int argc, char *argv[])
{

    QCoreApplication::setOrganizationName("Likalo.com");
    QCoreApplication::setOrganizationDomain("Likalo.com");
    QCoreApplication::setApplicationName("Wallsizer");

    QGuiApplication app(argc, argv);
    qmlRegisterType<DropArea>("com.Likalo.Drops", 1, 0, "DropZone");
    qmlRegisterType<MyThread>("com.Likalo.MyThread", 1, 0, "MyThread");


    QQmlApplicationEngine engine;
    ResolutionModel resolutionModel;
    DirModel dirModel;

    engine.rootContext()->setContextProperty("resolutionModel",&resolutionModel);
    engine.rootContext()->setContextProperty("dirModel",&dirModel);

    engine.load(QUrl("qrc:/qml/Wallsizer/main.qml"));

    return app.exec();

}
