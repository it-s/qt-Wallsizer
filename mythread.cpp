#include "mythread.h"
#include <cmath>
#include <QDebug>
#include <QSettings>
#include <QFileDialog>
#include "resolutionmodel.h"
MyThread::MyThread(QObject *parent) :
    QThread(parent)
{

}

void MyThread::run()
{

 mImageMagic.setResolutionsList(resolutions());
 qDebug()<<"start processing with "<<resolutions().count() << " Resolution(s)";

 // QString dir = QFileDialog::getExistingDirectory(m, tr("Open Directory"), "/home", QFileDialog::ShowDirsOnly | QFileDialog::DontResolveSymlinks);

// foreach (QUrl url, mUrls)
// {
//     qDebug()<<"process "<< url;
//     QUrl path = url;

//      mImageMagic.processImage(path.toLocalFile(),url.toLocalFile());
// }
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
