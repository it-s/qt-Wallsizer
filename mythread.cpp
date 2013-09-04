#include "mythread.h"
#include <cmath>
#include <QDebug>
#include <QSettings>
#include "resolutionmodel.h"
MyThread::MyThread(QObject *parent) :
    QThread(parent)
{

}

void MyThread::run()
{
    //Get back resolution settings


 qDebug()<<resolutions().count();


              double a = 50;
    for (double i = 0; i< 100000000; ++i)
    {
        a =sqrt(i)*2;
    }

    qDebug()<<"END !!";

}

QStringList MyThread::scalingMethodsModel()
{
    return mImageMagic.getScalingFilters();
}

QList<Resolution> MyThread::resolutions()
{
    QList<Resolution> resolutions;
    QSettings settings;
    int count = settings.value("mDatas_count",0).toInt();

    for(int i=0;i<count;++i){
        if (settings.value(QString("mDatas_%1_enabled").arg(i),false).toBool())
        {
            resolutions.append(Resolution(
                                   settings.value(QString("mDatas_%1_title").arg(i),"").toString(),
                                   settings.value(QString("mDatas_%1_width").arg(i),0).toInt(),
                                   settings.value(QString("mDatas_%1_height").arg(i),0).toInt(),
                                   settings.value(QString("mDatas_%1_compression").arg(i),100).toInt(),
                                   settings.value(QString("mDatas_%1_detailLow").arg(i),0).toInt(),
                                   settings.value(QString("mDatas_%1_detailMed").arg(i),0).toInt(),
                                   settings.value(QString("resolution_%1_detailHigh").arg(i),0).toInt(),
                                   settings.value(QString("mDatas_%1_enabled").arg(i),false).toBool()
                                   ));
        }

    }


return resolutions;
}

void MyThread::setUrls(const QStringList &urls)
{
    qDebug()<<"urls"<<urls;
    mUrls = urls;
}
