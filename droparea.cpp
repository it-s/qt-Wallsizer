#include "droparea.h"

#include <QDragEnterEvent>
#include <QMimeData>
#include <QStringList>

DropArea::DropArea(QQuickItem *parent)
    : QQuickItem(parent)
{
    setFlag(QQuickItem::ItemAcceptsDrops,true);
}

void DropArea::dragEnterEvent(QDragEnterEvent *event)
{
    bool acceptable = true;
    int reason = 0;
    if(!isValidImages(event->mimeData())){
        acceptable = false;
        reason = 1;
    }
    if(!isNotExceedingLimit(event->mimeData())){
        acceptable = false;
        reason = 2;
    }
    event->acceptProposedAction();
    emit entered(acceptable,reason);
}
//! [dragEnterEvent() function]

//! [dragMoveEvent() function]
void DropArea::dragMoveEvent(QDragMoveEvent *event)
{
    event->acceptProposedAction();
}
//! [dragMoveEvent() function]

//! [dropEvent() function part1]
void DropArea::dropEvent(QDropEvent *event)
{
    if (isValidImages(event->mimeData()) && isNotExceedingLimit(event->mimeData())) {
    const QMimeData *mimeData = event->mimeData();
    QList<QUrl> urlList = mimeData->urls();
    this->urls.append(urlList);
    event->acceptProposedAction();
    emit dropped(this->stringifyUrls(urlList));
    emit urlsChanged();
    }
}

bool DropArea::isValidImages(const QMimeData *mimeData)
{
    QList<QUrl> urlList = mimeData->urls();
    for (int i = 0; i < urlList.size() && i < 32; ++i) {
        if(!urlList.at(i).isValid())return false;
        QString url = urlList.at(i).path();
        if(!url.contains(".jpg", Qt::CaseInsensitive)&&
           !url.contains(".jpeg", Qt::CaseInsensitive)&&
           !url.contains(".png", Qt::CaseInsensitive)
           )return false;
    }
    return true;
}

bool DropArea::isNotExceedingLimit(const QMimeData *mimeData)
{
    QList<QUrl> urlList = mimeData->urls();
    return ((getCount()+urlList.length())<=this->imageMaxLimit);
}

QStringList DropArea::getUrls()
{
    return stringifyUrls(this->urls);
}

QStringList DropArea::stringifyUrls(QList<QUrl> _urls)
{
    QList<QString> urls;
    for (int i = 0; i < _urls.size(); ++i) {
        urls.append(_urls.at(i).toString());
    }
    return urls;
}

//! [dropEvent() function part3]

//! [dragLeaveEvent() function]
void DropArea::dragLeaveEvent(QDragLeaveEvent *event)
{
    event->accept();
    emit left();
}
//! [dragLeaveEvent() function]

int DropArea::getCount()
{
    return this->urls.length();
}

void DropArea::clear()
{
    QList<QUrl> urlList;
    this->urls = urlList;
    emit urlsChanged();
}

void DropArea::removeUrl(int index)
{
    this->urls.removeAt(index);
    emit urlsChanged();
}
