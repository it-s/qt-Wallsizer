#ifndef WALLSIZER_H
#define WALLSIZER_H

#include "im.h"
#include <QThread>
#include <QList>
#include <QObject>
#include <QQuickItem>
#include <QSettings>
#include <QThread>

//class ScalingMethod
//{
//    QString name;
//    char nameIM;
//};

class Resolution : public QObject
{
    Q_OBJECT
public:
    explicit Resolution(QObject *parent, QString _title, int _width, int _height, int _compression, int _detailLow, int _detailMedium, int _detailHigh, bool _enabled);
    Q_PROPERTY(QString title READ gettitle WRITE settitle NOTIFY titleChanged)
    Q_PROPERTY(int width READ getwidth WRITE setwidth NOTIFY widthChanged)
    Q_PROPERTY(int height READ getheight WRITE setheight NOTIFY heightChanged)
    Q_PROPERTY(int compression READ getcompression WRITE setcompression NOTIFY compressionChanged)
    Q_PROPERTY(int detailLow READ getdetailLow WRITE setdetailLow NOTIFY detailLowChanged)
    Q_PROPERTY(int detailMedium READ getdetailMed WRITE setdetailMed NOTIFY detailMedChanged)
    Q_PROPERTY(int detailHigh READ getdetailHigh WRITE setdetailHigh NOTIFY detailHighChanged)
    Q_PROPERTY(bool enabled READ getenabled WRITE setenabled NOTIFY enabledChanged)

    QString gettitle(){return title;}
    void settitle(QString _title){title=_title;emit titleChanged();}
    int getwidth(){return width;}
    void setwidth(int _width){width=_width;emit widthChanged();}
    int getheight(){return height;}
    void setheight(int _height){height=_height;emit heightChanged();}
    int getcompression(){return compression;}
    void setcompression(int _compression){compression=_compression;emit compressionChanged();}
    int getdetailLow(){return detailLow;}
    void setdetailLow(int _detailLow){detailLow=_detailLow;emit detailLowChanged();}
    int getdetailMed(){return detailMed;}
    void setdetailMed(int _detailMed){detailMed=_detailMed;emit detailMedChanged();}
    int getdetailHigh(){return detailHigh;}
    void setdetailHigh(int _detailHigh){detailHigh=_detailHigh;emit detailHighChanged();}
    bool getenabled(){return enabled;}
    void setenabled(bool _enabled){enabled=_enabled;emit enabledChanged();}

signals:
    void titleChanged();
    void widthChanged();
    void heightChanged();
    void compressionChanged();
    void detailLowChanged();
    void detailMedChanged();
    void detailHighChanged();
    void enabledChanged();

private:
    QString title;
    int width;
    int height;
    int compression;
    int detailLow;
    int detailMed;
    int detailHigh;
    bool enabled;
};

class Wallsizer : public QObject
{
    Q_OBJECT
public:
    explicit Wallsizer(QObject *parent = 0);
    Q_PROPERTY(bool saveIntoSameFolder READ getsaveSame WRITE setsaveSame NOTIFY saveSameChanged)
    Q_PROPERTY(bool alwaysAskWhereToSave READ getsaveAks WRITE setsaveAsk NOTIFY saveAksChanged)
    Q_PROPERTY(QString defaultSavePath READ getsavePath WRITE setsavePath NOTIFY savePathChanged)
    Q_PROPERTY(QString tempSavePath READ gettmpSavePath WRITE settmpSavePath NOTIFY savePathChanged)
    Q_PROPERTY(QStringList urlsToProcess READ geturlsToProcess WRITE seturlsToProcess NOTIFY urlsToProcessChanged)
    Q_PROPERTY(QStringList scalingMethodsModel READ getscalingMethods NOTIFY scalingMethodsChnaged)
    Q_PROPERTY(QVariant resolutionsModel READ getmodel NOTIFY resolutionsChanged)
    Q_INVOKABLE int resolutionsModelCount();
    Q_INVOKABLE void resolutionsModelAdd();
    Q_INVOKABLE QVariant resolutionsModelGet(int index);
    Q_INVOKABLE void resolutionsModelSet(int index, QVariantMap item);
    Q_INVOKABLE void resolutionsModelDelete(int index);
    Q_INVOKABLE void resolutionsModelReset();
    Q_INVOKABLE void save();
    Q_INVOKABLE void pricessUrls();

private:
    bool getsaveAks(){ return saveAsk; }
    void setsaveAsk(bool _v){saveAsk=_v;}
    bool getsaveSame(){ return saveSame; }
    void setsaveSame(bool _v){saveSame=_v;}
    QString getsavePath(){ return savePath; }
    void setsavePath(QString _path){savePath=_path;}
    QString gettmpSavePath(){ return tmpSavePath; }
    void settmpSavePath(QString _path){tmpSavePath=_path;}
    void seturlsToProcess(QStringList urls){urlsList = urls;}
    QStringList geturlsToProcess(){return urlsList;}
    QVariant getmodel(){ return QVariant::fromValue(resolutions); }
    QStringList getscalingMethods(){return imageMagic.getScalingFilters();}

    void saveSettings();
    void readSettings();

signals:
    void saveAksChanged();
    void saveSameChanged();
    void savePathChanged();
    void urlsToProcessChanged();
    void resolutionsChanged();
    void resolutionsModelAdded();
    void resolutionsModelRemoved(int index);
    void scalingMethodsChnaged();
    void processUrlsComplete();
    void processUrlsStarted();
    void processUrlsError(QString error);

public slots:


private:
    bool saveAsk;
    bool saveSame;
    QString savePath;
    QString tmpSavePath;
    QStringList urlsList;
    QList<QObject*> resolutions;
    QList<QObject*> resolutionsOld;
    QSettings settings;
    IM imageMagic;

};




#endif // WALLSIZER_H
