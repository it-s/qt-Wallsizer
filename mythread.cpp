#include "mythread.h"
#include <cmath>
#include <QDebug>
MyThread::MyThread(QObject *parent) :
    QThread(parent)
{
}

void MyThread::run()
{
    qDebug()<<"RUN !!";
    double a = 50;
    for (double i = 0; i< 100000000; ++i)
    {
        a =sqrt(i)*2;
    }

    qDebug()<<"END !!";

}


void MyThread::setUrls(const QStringList &urls)
{
    mUrls = urls;
}
