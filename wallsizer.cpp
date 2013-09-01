#include "wallsizer.h"

#include <QMap>
#include <QUrl>
#include <QDebug>

Wallsizer::Wallsizer(QQuickItem *parent) :
    QQuickItem(parent)
{
    readSettings();
    tmpSavePath = "";

//    configurationWindow = new ConfigurationWindow();
}

int Wallsizer::resolutionsModelCount()
{
    return resolutions.count();
}

void Wallsizer::resolutionsModelAdd()
{
    resolutions.append(new Resolution(this,"Untitled",0,0,100,0,0,0,false));
    emit resolutionsChanged();
    emit resolutionsModelAdded();
}

QVariant Wallsizer::resolutionsModelGet(int index)
{
    return QVariant::fromValue(resolutions.at(index));
}

void Wallsizer::resolutionsModelSet(int index, QVariantMap item)
{
    resolutions.replace(index, new Resolution(
                            this,
                            (QString)item.value("title").toString(),
                            item.value("width").toInt(),
                            item.value("height").toInt(),
                            item.value("compression").toInt(),
                            item.value("detailLow").toInt(),
                            item.value("detailMedium").toInt(),
                            item.value("detailHigh").toInt(),
                            item.value("enabled").toBool()
                            ));
    emit resolutionsChanged();
}

void Wallsizer::resolutionsModelDelete(int index)
{
    resolutions.removeAt(index);
    emit resolutionsChanged();
    emit resolutionsModelRemoved(index-1);
}

void Wallsizer::resolutionsModelReset()
{
    resolutions = resolutionsOld;
    emit resolutionsChanged();
}

void Wallsizer::save()
{
    saveSettings();
}

void Wallsizer::pricessUrls()
{
    if(urlsList.count()==0){emit(processUrlsError("No images added to the drop target area. Add images first."));return;}

    QList<QMap<QString, int> > list;
    for(int i=0;i<resolutions.count();++i){
        QObject* res = resolutions.at(i);
        if(res->property("enabled").toBool()){
            QMap<QString, int> map;
            map["width"] = res->property("width").toInt();
            map["height"] = res->property("height").toInt();
            map["compression"] = res->property("compression").toInt();
            map["detailLow"] = res->property("detailLow").toInt();
            map["detailMedium"] = res->property("detailMedium").toInt();
            map["detailHigh"] = res->property("detailHigh").toInt();
            list.append(map);
        }
    }
    if(list.count()==0){emit(processUrlsError("No resolutions selected. Go to settings screen and enable some."));return;}

    emit processUrlsStarted();
    imageMagic.setResolutionsList(list);

    for(int i=0;i<urlsList.count();++i){
        QUrl url = QUrl(urlsList.at(i));
        QUrl path = saveSame?url: //save into the same dir as image is in
                             saveAsk?QUrl(tmpSavePath): //save into directory chosen
                                     QUrl(savePath); //save into selected default path;
//        qDebug() << "File name: " << url.toLocalFile();
//        qDebug() << "File path: " << path.toLocalFile();
        //TODO: Send this over to IM along with default save path and list of resolutions
        if(!imageMagic.processImage(path.toLocalFile(),url.toLocalFile())&&imageMagic.errors()){
            emit(processUrlsError(imageMagic.getErrorDescription(url.toLocalFile())));
            return;
        }
//        if(!imageMagic.processImageTest(path.toLocalFile(),url.toLocalFile())&&imageMagic.errors()){
//            emit(processUrlsError(imageMagic.getErrorDescription(url.toLocalFile())));
//            return;
//        }
    }
    emit(processUrlsComplete());
}

void Wallsizer::saveSettings()
{
    resolutionsOld = resolutions;
    settings.setValue("saveAsk",saveAsk);
    settings.setValue("saveSame",saveSame);
    settings.setValue("savePath",savePath);

    int _count = resolutions.count();
    settings.setValue("resolutions_count",_count);
    for(int i=0;i<_count;++i){
        QObject* res = resolutions.at(i);
        settings.setValue(QString("resolutions_%1_title").arg(i),res->property("title"));
        settings.setValue(QString("resolutions_%1_width").arg(i),res->property("width"));
        settings.setValue(QString("resolutions_%1_height").arg(i),res->property("height"));
        settings.setValue(QString("resolutions_%1_compression").arg(i),res->property("compression"));
        settings.setValue(QString("resolutions_%1_detailLow").arg(i),res->property("detailLow"));
        settings.setValue(QString("resolutions_%1_detailMed").arg(i),res->property("detailMedium"));
        settings.setValue(QString("resolution_%1_detailHigh").arg(i),res->property("detailHigh"));
        settings.setValue(QString("resolutions_%1_enabled").arg(i),res->property("enabled"));
    }
}

void Wallsizer::readSettings()
{
    saveAsk = settings.value("saveAsk",false).toBool();
    saveSame = settings.value("saveSame",true).toBool();
    savePath = settings.value("savePath","").toString();

    int _count = settings.value("resolutions_count",0).toInt();
    if(_count==0){
        //First run. Preload resolutions:
        resolutions.append(new Resolution(this,"VGA",640,480,100,3,2,0,false));
        resolutions.append(new Resolution(this,"SVGA",800,600,100,3,2,0,false));
        resolutions.append(new Resolution(this,"WSVGA",1024,600,95,3,2,0,false));
        resolutions.append(new Resolution(this,"XGA",1024,768,95,3,2,0,true));
        resolutions.append(new Resolution(this,"XGA+",1152,864,95,3,2,0,false));
        resolutions.append(new Resolution(this,"WXGA",1280,720,95,3,2,0,false));
        resolutions.append(new Resolution(this,"WXGA",1280,768,95,2,2,0,false));
        resolutions.append(new Resolution(this,"WXGA",1280,800,95,2,2,0,true));
        resolutions.append(new Resolution(this,"SXGA–(UVGA)",1280,960,95,2,2,0,false));
        resolutions.append(new Resolution(this,"SXGA",1280,1024,90,2,2,0,true));
        resolutions.append(new Resolution(this,"HD",1360,768,90,2,2,0,false));
        resolutions.append(new Resolution(this,"HD",1366,768,90,2,2,0,true));
        resolutions.append(new Resolution(this,"SXGA+",1400,1050,90,2,2,0,false));
        resolutions.append(new Resolution(this,"WXGA+",1440,900,90,2,2,0,true));
        resolutions.append(new Resolution(this,"HD+",1600,900,90,2,2,0,true));
        resolutions.append(new Resolution(this,"UXGA",1600,1200,90,4,4,4,false));
        resolutions.append(new Resolution(this,"WSXGA+",1680,1050,90,4,4,4,true));
        resolutions.append(new Resolution(this,"FHD",1920,1080,90,4,4,4,true));
        resolutions.append(new Resolution(this,"WUXGA",1920,1200,90,4,4,4,false));
        resolutions.append(new Resolution(this,"QWXGA",2048,1152,90,3,3,3,false));
        resolutions.append(new Resolution(this,"WQHD",2560,1440,90,3,3,3,false));
        resolutions.append(new Resolution(this,"WQXGA",2560,1600,90,3,3,3,false));
    }else{
        for(int i=0;i<_count;++i){
            resolutions.append(new Resolution(
                                   this,
                                   settings.value(QString("resolutions_%1_title").arg(i),"").toString(),
                                   settings.value(QString("resolutions_%1_width").arg(i),0).toInt(),
                                   settings.value(QString("resolutions_%1_height").arg(i),0).toInt(),
                                   settings.value(QString("resolutions_%1_compression").arg(i),100).toInt(),
                                   settings.value(QString("resolutions_%1_detailLow").arg(i),0).toInt(),
                                   settings.value(QString("resolutions_%1_detailMed").arg(i),0).toInt(),
                                   settings.value(QString("resolution_%1_detailHigh").arg(i),0).toInt(),
                                   settings.value(QString("resolutions_%1_enabled").arg(i),false).toBool()
                                   ));
        }
    }
    resolutionsOld = resolutions;
}

Resolution::Resolution(QObject *parent, QString _title, int _width, int _height, int _compression, int _detailLow, int _detailMedium, int _detailHigh, bool _enabled) :
    QObject(parent)
{
    title = _title;
    width = _width;
    height = _height;
    compression = _compression;
    detailLow = _detailLow;
    detailMed = _detailMedium;
    detailHigh = _detailHigh;
    enabled = _enabled;
}
