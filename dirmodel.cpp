#include "dirmodel.h"
#include <QDir>
#include <QDebug>
DirModel::DirModel(QObject *parent) :
    QAbstractListModel(parent)
{

    setRootPath(QDir::homePath());

}

int DirModel::rowCount(const QModelIndex &parent) const
{
    return mFolders.count();
}

QVariant DirModel::data(const QModelIndex &index, int role) const
{
    if (role == Qt::DisplayRole)
        return mFolders.at(index.row());

    return QVariant();

}

 QString DirModel::path(int row)
{
    if (row < mFolders.count())
        return mFolders.at(row);
    return QString();
}

void DirModel::setRootPath(const QString &path)
{
    qDebug()<<path;

    beginResetModel();
    mDir.setCurrent(path);
    mFolders = mDir.entryList(QDir::AllDirs);
    endResetModel();


}
