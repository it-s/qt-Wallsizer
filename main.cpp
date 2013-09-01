#include "droparea.h"
#include "wallsizer.h"

#include <QSize>
#include <QtQuick/QQuickView>
#include <QGuiApplication>
#include "qtquick2applicationviewer.h"

int main(int argc, char *argv[])
{

    QCoreApplication::setOrganizationName("Likalo.com");
    QCoreApplication::setOrganizationDomain("Likalo.com");
    QCoreApplication::setApplicationName("Wallsizer");

    QGuiApplication app(argc, argv);

    qmlRegisterType<DropArea>("Drops", 1, 0, "DropZone");
    qmlRegisterType<Wallsizer>("Wallsizer", 1, 0, "Wallsizer");

    QtQuick2ApplicationViewer viewer;
//    viewer.setMainQmlFile(QStringLiteral("qml/Wallsizer/main.qml"));
    viewer.setSource(QUrl("qrc:/qml/Wallsizer/main.qml"));
    viewer.setMinimumSize(QSize(360,360));
    viewer.setIcon(QIcon("qrc:/icons/Wallsizer64.png"));
//    viewer.setMaximumSize(QSize(360,360));
    viewer.showExpanded();

    return app.exec();
}
