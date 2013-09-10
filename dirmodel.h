#ifndef DIRMODEL_H
#define DIRMODEL_H

#include <QAbstractListModel>
#include <QDir>
class DirModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit DirModel(QObject *parent = 0);
    int rowCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;
    Q_INVOKABLE  QString path(int row);

public slots:
    void setRootPath(const QString& path);

private:
    QStringList mFolders;
    QDir mDir;
    
};

#endif // DIRMODEL_H
