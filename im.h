#ifndef IM_H
#define IM_H

#include <QMap>
#include <QList>
#include <QString>
#include <QStringList>

#include <Magick++.h>
#include <iostream>

using namespace std;
using namespace Magick;

class IM
{
public:
    IM();
    bool processImage(QString _savePath, QString _imageURL);
    bool processImageTest(QString _savePath, QString _imageURL);
    void setResolutionsList(QList<QMap<QString, int> > _resolutionsList){resolutionsList=_resolutionsList;}

    QStringList getScalingFilters(){return (QStringList)filters.keys();}

    bool errors(){return error!=0;}
    QString getErrorDescription(QString item="");

private:
    int error;
    QList<QMap<QString, int> > resolutionsList;
//    QStringList filterList;
    QMap<QString,MagickCore::FilterTypes> filters;

    int rateDetailLevel(Image _image);
    Image createResizedVersion(Image _image, int width, int height, MagickCore::FilterTypes filter);
    void saveAs(Image _image, string fileName, int quality);
    MagickCore::FilterTypes getFilterAt(int index){return filters.value(getFilterNameAt(index));}
    QString getFilterNameAt(int index){return filters.count()<index?getScalingFilters().at(index):getScalingFilters().at(0);}

};

#endif // IM_H
