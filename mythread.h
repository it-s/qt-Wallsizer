#ifndef MYTHREAD_H
#define MYTHREAD_H

#include <QThread>
#include <QStringList>
#include <QStringListModel>
#include "im.h"
#include "resolutionmodel.h"
class MyThread : public QThread
{
    Q_OBJECT
public:
    explicit MyThread(QObject *parent = 0);

    virtual void run();

    Q_INVOKABLE QStringList scalingMethodsModel();

protected:
    QList<Resolution> resolutions();

public slots:
    void setUrls(const QStringList& urls);

private:
    QStringList mUrls;
    IM mImageMagic;

    
};

#endif // MYTHREAD_H
