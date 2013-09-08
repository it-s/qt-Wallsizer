#ifndef DROPAREA_H
#define DROPAREA_H

#include <QQuickItem>

QT_BEGIN_NAMESPACE
class QMimeData;
QT_END_NAMESPACE

class DropArea : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QStringList urls READ getUrls NOTIFY urlsChanged)
    Q_PROPERTY(int count READ getCount NOTIFY urlsChanged)

public:
    explicit DropArea(QQuickItem *parent = 0);
    Q_INVOKABLE void clear();
    Q_INVOKABLE void removeUrl(int index);

signals:
    void urlsChanged();
    void dropped(const QStringList urlsDropped);
    void entered(const bool acceptable = false, const int reason = 0);
    void left();
    void cleared();

protected:
    void dragEnterEvent(QDragEnterEvent *event);
    void dragMoveEvent(QDragMoveEvent *event);
    void dragLeaveEvent(QDragLeaveEvent *event);
    void dropEvent(QDropEvent *event);
    bool isValidImages(const QMimeData *mimeData);
    bool isNotExceedingLimit(const QMimeData *mimeData);
    QStringList getUrls();
    QStringList stringifyUrls(QList<QUrl> _urls);
    int getCount();

private:
    static const int imageMaxLimit = 12;
    QList<QUrl> urls;

};

#endif // DROPAREA_H
