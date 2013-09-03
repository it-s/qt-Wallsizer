#ifndef MYTHREAD_H
#define MYTHREAD_H

#include <QThread>
#include <QStringList>

class MyThread : public QThread
{
    Q_OBJECT
public:
    explicit MyThread(QObject *parent = 0);

    virtual void run();

public slots:
    void setUrls(const QStringList& urls);

private:
    QStringList mUrls;
    
};

#endif // MYTHREAD_H
