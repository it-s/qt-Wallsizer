#include "resolutionmodel.h"

ResolutionModel::ResolutionModel(QObject *parent) :
    QAbstractListModel(parent)
{

}

int ResolutionModel::rowCount(const QModelIndex &parent) const
{

    return mDatas.count();

}

QVariant ResolutionModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    if (role == TitleRole)
        return mDatas.at(index.row()).title;

    if (role == WidthRole)
        return mDatas.at(index.row()).width;

    if (role == HeightRole)
        return mDatas.at(index.row()).height;

    if (role == CompressionRole)
        return mDatas.at(index.row()).compression;

    if (role == DetailLowRole)
        return mDatas.at(index.row()).detailLow;

    if (role == DetailMediumRole)
        return mDatas.at(index.row()).detailMed;

    if (role == DetailHighRole)
        return mDatas.at(index.row()).detailHigh;

    if (role == EnabledRole)
        return mDatas.at(index.row()).enabled;


    return QVariant();

}

QHash<int, QByteArray> ResolutionModel::roleNames() const
{
    //associate Role with names
    QHash<int, QByteArray> names;

    names[TitleRole] = "title";
    names[WidthRole] = "width";
    names[HeightRole] = "height";
    names[CompressionRole] = "compression";
    names[DetailLowRole] = "detailLow";
    names[DetailMediumRole] = "detailMedium";
    names[DetailHighRole] = "detailHigh";
    names[EnabledRole] = "enabled";
    return names;
}

QVariant ResolutionModel::resolution(int id)
{
    QMap<QString, QVariant> resolution;
    //generate array of resolution to export to JS object
    if (index(id).isValid()) {

        foreach (QByteArray name, roleNames().values())
        {
            int role = roleNames().key(name);
            resolution.insert(name, data(index(id),role));

        }
    }
    return QVariant(resolution);
}

void ResolutionModel::remove(int row)
{
    beginRemoveRows(QModelIndex(),row,row);
    mDatas.removeAt(row);
    endRemoveRows();
}

void ResolutionModel::update(int row, const QVariantMap &item)
{
    qDebug()<<item;
    Resolution resolution;
    resolution.title = item["title"].toString();
    resolution.width = item["width"].toInt();
    resolution.height = item["height"].toInt();
    resolution.compression = item["compression"].toInt();
    resolution.detailLow = item["detailLow"].toInt();
    resolution.detailMed = item["detailMed"].toInt();
    resolution.detailHigh = item["detailHigh"].toInt();
    resolution.enabled = item["enabled"].toBool();

    if (row <0)
    {
        beginInsertRows(QModelIndex(),0,0);
        mDatas.prepend(resolution);
        endInsertRows();
    }

    else {
        mDatas[row] = resolution;
        emit dataChanged(index(row), index(row));
    }


}

void ResolutionModel::saveSettings()
{
    QSettings settings;
    settings.setValue("saveAsk",saveAsk());
    settings.setValue("saveSame",saveSame());
    settings.setValue("savePath",savePath());

    qDebug()<<"save save ask "<<saveAsk();

    int _count = mDatas.count();
    settings.setValue("mDatas_count",_count);
    for(int i=0;i<_count;++i){
        Resolution res = mDatas.at(i);
        settings.setValue(QString("mDatas_%1_title").arg(i),res.title);
        settings.setValue(QString("mDatas_%1_width").arg(i),res.width);
        settings.setValue(QString("mDatas_%1_height").arg(i),res.height);
        settings.setValue(QString("mDatas_%1_compression").arg(i),res.compression);
        settings.setValue(QString("mDatas_%1_detailLow").arg(i),res.detailLow);
        settings.setValue(QString("mDatas_%1_detailMed").arg(i),res.detailMed);
        settings.setValue(QString("resolution_%1_detailHigh").arg(i),res.detailHigh);
        settings.setValue(QString("mDatas_%1_enabled").arg(i),res.enabled);


    }
}

void ResolutionModel::readSettings()
{
    QSettings settings;
    setSaveAsk(settings.value("saveAsk",false).toBool());
    setSaveSame(settings.value("saveSame",true).toBool());
    setSavePath(settings.value("savePath","").toString());

    qDebug()<<"read save ask "<<saveAsk();

    int count = settings.value("mDatas_count",0).toInt();
    if(!count){
        //First run. Preload mDatas:
        mDatas.append(Resolution("VGA",640,480,100,3,2,0,false));
        mDatas.append(Resolution("SVGA",800,600,100,3,2,0,false));
        mDatas.append(Resolution("WSVGA",1024,600,95,3,2,0,false));
        mDatas.append(Resolution("XGA",1024,768,95,3,2,0,true));
        mDatas.append(Resolution("XGA+",1152,864,95,3,2,0,false));
        mDatas.append(Resolution("WXGA",1280,720,95,3,2,0,false));
        mDatas.append(Resolution("WXGA",1280,768,95,2,2,0,false));
        mDatas.append(Resolution("WXGA",1280,800,95,2,2,0,true));
        mDatas.append(Resolution("SXGA–(UVGA)",1280,960,95,2,2,0,false));
        mDatas.append(Resolution("SXGA",1280,1024,90,2,2,0,true));
        mDatas.append(Resolution("HD",1360,768,90,2,2,0,false));
        mDatas.append(Resolution("HD",1366,768,90,2,2,0,true));
        mDatas.append(Resolution("SXGA+",1400,1050,90,2,2,0,false));
        mDatas.append(Resolution("WXGA+",1440,900,90,2,2,0,true));
        mDatas.append(Resolution("HD+",1600,900,90,2,2,0,true));
        mDatas.append(Resolution("UXGA",1600,1200,90,4,4,4,false));
        mDatas.append(Resolution("WSXGA+",1680,1050,90,4,4,4,true));
        mDatas.append(Resolution("FHD",1920,1080,90,4,4,4,true));
        mDatas.append(Resolution("WUXGA",1920,1200,90,4,4,4,false));
        mDatas.append(Resolution("QWXGA",2048,1152,90,3,3,3,false));
        mDatas.append(Resolution("WQHD",2560,1440,90,3,3,3,false));
        mDatas.append(Resolution("WQXGA",2560,1600,90,3,3,3,false));
    }
    else{
        for(int i=0;i<count;++i){
            mDatas.append(Resolution(
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

    beginInsertRows(QModelIndex(),0, mDatas.count()-1);
    endInsertRows();

}



