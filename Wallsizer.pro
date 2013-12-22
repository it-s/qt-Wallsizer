
QT += widgets quick


# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    droparea.cpp \
#    wallsizer.cpp \
    im.cpp \
    mythread.cpp \
    resolutionmodel.cpp \
    dirmodel.cpp

HEADERS += \
    droparea.h \
#    wallsizer.h \
    im.h \
    mythread.h \
    resolutionmodel.h \
    dirmodel.h

#unix:!macx: LIBS += -lMagick++

#INCLUDEPATH += /usr/include/GraphicsMagick/
CONFIG += link_pkgconfig
#PKGCONFIG += GraphicsMagick++
PKGCONFIG += ImageMagick++

RESOURCES += \
    resources.qrc

OTHER_FILES += \
    qml/Wallsizer/MessageOverlay.qml \
    qml/Wallsizer/main.qml \
    qml/Wallsizer/IndicatorOverlay.qml \
    qml/Wallsizer/ImageFrame.qml \
    qml/Wallsizer/DropTargetArea.qml \
    qml/Wallsizer/GUI/EditWindow.qml \
    qml/Wallsizer/GUI/ConfigWindow.qml \
    qml/Wallsizer/GUI/Theme/Variables.qml \
    qml/Wallsizer/GUI/Theme/MyUITextFieldStyle.qml \
    qml/Wallsizer/GUI/Theme/MyUITableViewStyleRow.qml \
    qml/Wallsizer/GUI/Theme/MyUITableViewStyleItem.qml \
    qml/Wallsizer/GUI/Theme/MyUITableViewStyleHeader.qml \
    qml/Wallsizer/GUI/Theme/MyUISpacer.qml \
    qml/Wallsizer/GUI/Theme/MyUISliderStyle.qml \
    qml/Wallsizer/GUI/Theme/MyUILabel.qml \
    qml/Wallsizer/GUI/Theme/MyUIHeading.qml \
    qml/Wallsizer/GUI/Theme/MyUIcon.qml \
    qml/Wallsizer/GUI/Theme/MyUIComboBoxStyle.qml \
    qml/Wallsizer/GUI/Theme/MyUICheckBoxStyle.qml \
    qml/Wallsizer/GUI/Theme/MyUIButtonStyle.qml \
    qml/Wallsizer/GUI/Theme/MyUIAlert.qml \
    qml/Wallsizer/MyToolBar.qml \
    qml/Wallsizer/GUI/Theme/Base/BaseText.qml \
    qml/Wallsizer/GUI/Theme/Base/BaseElement.qml \
    qml/Wallsizer/GUI/MyFileDialog.qml

