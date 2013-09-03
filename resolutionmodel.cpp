#include "resolutionmodel.h"

ResolutionModel::ResolutionModel(QObject *parent) :
    QAbstractListModel(parent)
{


    Resolution temp;
    temp.title ="VSA";
    temp.detailHigh = 5;
    temp.detailLow= 4;
    temp.detailMed=10;
    temp.enabled= true;
    temp.width= 640;
    temp.height=480;

    mDatas.append(temp);
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

    if (role == DetailMedRole)
        return mDatas.at(index.row()).detailMed;

    if (role == EnabledRole)
        return mDatas.at(index.row()).enabled;


        return QVariant();

}

QHash<int, QByteArray> ResolutionModel::roleNames() const
{

    QHash<int, QByteArray> names;

    names[TitleRole] = "title";
    names[WidthRole] = "width";
    names[HeightRole] = "height";
    names[CompressionRole] = "compression";
    names[DetailLowRole] = "low";
    names[DetailMedRole] = "med";
    names[DetailHighRole] = "high";
    names[EnabledRole] = "enabled";

    return names;


}