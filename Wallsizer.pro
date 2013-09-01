# Add more folders to ship with the application, here
#folder_01.source = qml/Wallsizer
#folder_01.target = qml
#DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

QT += widgets

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    droparea.cpp \
    wallsizer.cpp \
    im.cpp

# Installation path
# target.path =

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

HEADERS += \
    droparea.h \
    wallsizer.h \
    im.h

unix:!macx: LIBS += -lMagick++

#INCLUDEPATH += /usr/include/GraphicsMagick/
CONFIG += link_pkgconfig
#PKGCONFIG += GraphicsMagick++
PKGCONFIG += ImageMagick++

RESOURCES += \
    resources.qrc

