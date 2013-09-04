#ifndef RESOLUTIONMODEL_H
#define RESOLUTIONMODEL_H

#include <QAbstractListModel>
#include <QtCore>
class Resolution{
public:
    Resolution(){}
    Resolution(const QString& t,int w,int h,int c,
               int dl,int dm,int dh,bool e) {
        title = t;
        width = w;
        height=h;
        compression=c;
        detailLow=dl;
        detailMed=dm;
        detailHigh=dh;
        enabled=e;
    }

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

public:
    Q_PROPERTY(bool saveAsk READ saveAsk WRITE setSaveAsk NOTIFY saveAskChanged)
    Q_PROPERTY(bool saveSame READ saveSame WRITE setSaveSame NOTIFY saveSameChanged)
    Q_PROPERTY(QString savePath READ savePath WRITE setSavePath NOTIFY savePathChanged)

    enum ResolutionRole{
        TitleRole = Qt::UserRole+1,
        WidthRole,
        HeightRole,
        CompressionRole,
        DetailLowRole,
        DetailMediumRole,
        DetailHighRole,
        EnabledRole
    };

    explicit ResolutionModel(QObject *parent = 0);
    virtual int rowCount(const QModelIndex &parent) const;
    virtual QVariant data(const QModelIndex &index, int role) const;
    virtual QHash<int, QByteArray> roleNames() const;
    Q_INVOKABLE QVariant resolution(int id);
    Q_INVOKABLE void remove(int row);
    Q_INVOKABLE void update(int row, const QVariantMap& item);
    Q_INVOKABLE void saveSettings();
    Q_INVOKABLE void readSettings();

    bool saveAsk(){return mSaveAsk;}
    bool saveSame(){return mSaveSame;}
    QString savePath(){return mSavePath;}

    void setSaveAsk(bool enable) {mSaveAsk = enable; emit saveAskChanged();}
    void setSaveSame(bool enable) {mSaveSame = enable;emit saveSameChanged();}
    void setSavePath(const QString& path) {mSavePath = path;emit savePathChanged();}

signals:
    void saveAskChanged();
    void saveSameChanged();
    void savePathChanged();


private:
    QList<Resolution> mDatas;
    bool mSaveAsk;
    bool mSaveSame;
    QString mSavePath;

};

#endif // RESOLUTIONMODEL_H
