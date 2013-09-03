#ifndef RESOLUTIONMODEL_H
#define RESOLUTIONMODEL_H

#include <QAbstractListModel>
#include <QtCore>
class Resolution{
public:
    QString title;
    int width;
    int height;
    int compression;
    int detailLow;
    int detailMed;
    int detailHigh;
    bool enabled;


};

class ResolutionModel : public QAbstractListModel
{
    Q_OBJECT
    enum {
        TitleRole = Qt::UserRole+1,
        WidthRole,
        HeightRole,
        CompressionRole,
        DetailLowRole,
        DetailMedRole,
        DetailHighRole,
        EnabledRole
    };
public:
    explicit ResolutionModel(QObject *parent = 0);
    int rowCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const;

private:
    QList<Resolution> mDatas;

};

#endif // RESOLUTIONMODEL_H
