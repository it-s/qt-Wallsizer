#include "im.h"

#include <QDir>
#include <QFileInfo>
#include <QDebug>
#include <qmath.h>

IM::IM()
{
    //Init IM here    
    InitializeMagick(NULL);

    //Scaling methods
//    LanczosFilter
//    BlackmanFilter
//    MitchellFilter
//    SincFilter
//    BoxFilter
    filters.insert("Lanczos Filter",MagickCore::LanczosFilter);
    filters.insert("Blackman Filter",MagickCore::BlackmanFilter);
    filters.insert("Mitchell Filter",MagickCore::MitchellFilter);
    filters.insert("Sinc Filter",MagickCore::SincFilter);
    filters.insert("Box Filter",MagickCore::BoxFilter);

    error = 0;
}

bool IM::processImage(QString _savePath, QString _imageURL)
{
    QFileInfo __savePath = QFileInfo(_savePath);
    QDir savePath = QFileInfo(_savePath).dir();
    if(__savePath.isDir())savePath = QDir(_savePath);
    qDebug() << savePath.absolutePath();
    if(!savePath.exists()){error = 1;return false;}
    QFileInfo imageURL = QFileInfo(_imageURL);
    QString baseFilename = imageURL.baseName();
    qDebug() << imageURL.fileName();
    qDebug() << "Base Name: " << baseFilename;
    if(!imageURL.exists()||!imageURL.isReadable()){error = 2;return false;}
    if (!savePath.exists(baseFilename)){ if(!savePath.mkdir(baseFilename)){error = 3;return false;}};
    QDir finalSavePath = QDir(savePath.absoluteFilePath(baseFilename));
    qDebug() << finalSavePath.path();
    //IM stuff starts here
    Image image;
    image.read(imageURL.absoluteFilePath().toStdString());
    int imageRate = rateDetailLevel(image);

    for(int i=0; i<resolutionsList.count();++i){
//        QMap<QString, int> res = resolutionsList.at(i);
        Resolution res = resolutionsList.at(i);
        if(res.width==0||res.height==0)continue; //Skip the resolution if it's incomplete

        QFileInfo file = QFileInfo(finalSavePath,QString("%1_%2x%3.jpg").arg(baseFilename).arg(res.width).arg(res.height));
        qDebug() << "File name: "<<file.absoluteFilePath();

        int resizingAlgorithm = 0;
        switch (imageRate) {
        case 1:
            resizingAlgorithm = res.detailLow;
            break;
        case 2:
            resizingAlgorithm = res.detailMed;
            break;
        case 3:
            resizingAlgorithm = res.detailHigh;
            break;
        default:
            break;
        }

        Image resizedImage = createResizedVersion(image,res.width,res.height,getFilterAt(resizingAlgorithm));
        saveAs(resizedImage,file.absoluteFilePath().toStdString(),res.compression);
        if(!file.exists()){error = 4;return false;}
    }
    return true;
}

//bool IM::processImageTest(QString _savePath, QString _imageURL)
//{
//    QFileInfo __savePath = QFileInfo(_savePath);
//    QDir savePath = QFileInfo(_savePath).dir();
//    if(__savePath.isDir())savePath = QDir(_savePath);
//    qDebug() << savePath.absolutePath();
//    if(!savePath.exists()){error = 1;return false;}
//    QFileInfo imageURL = QFileInfo(_imageURL);
//    QString baseFilename = imageURL.baseName();
//    qDebug() << imageURL.fileName();
//    qDebug() << "Base Name: " << baseFilename;
//    if(!imageURL.exists()||!imageURL.isReadable()){error = 2;return false;}
//    if (!savePath.exists(baseFilename)){ if(!savePath.mkdir(baseFilename)){error = 3;return false;}};
//    QDir finalSavePath = QDir(savePath.absoluteFilePath(baseFilename));
//    qDebug() << finalSavePath.path();
//    //IM stuff starts here
//    Image image;
//    image.read(imageURL.absoluteFilePath().toStdString());
//    int imageRate = rateDetailLevel(image);

//    for(int i=0; i<resolutionsList.count();++i){
//        Resolution res = resolutionsList.at(i);
//        for(int j=0; j<filters.count();++j){

//            QFileInfo file = QFileInfo(finalSavePath,QString("%1_%2x%3_%4-%5.jpg").arg(baseFilename).arg(res.width).arg(res.height).arg(imageRate).arg(getFilterNameAt(j)));
//            qDebug() << "File name: "<<file.absoluteFilePath();

//            Image resizedImage = createResizedVersion(image,res.width,res.height,getFilterAt(j));
//            saveAs(resizedImage,file.absoluteFilePath().toStdString(),res.compression);
//            if(!file.exists()){error = 4;return false;}
//        }

//    }
//    return true;
//}

QString IM::getErrorDescription(QString item)
{
    switch(error){
    case(0):
        return QString("No errors processing %1").arg(item);
        break;
    case(1):
        return QString("Save directory path des not exist or is unaccessible.\n %1").arg(item);
        break;
    case(2):
        return QString("Image file does not exist or is unaccesible.\n %1").arg(item);
        break;
    case(3):
        return QString("Could not create subdirectory at the location specified.\n %1").arg(item);
        break;
    case(4):
        return QString("Faled to save resized image. Is the save path writable?\n %1").arg(item);
        break;
    default:
        return QString("Unknown error while processing %1").arg(item);
    }
}

int IM::rateDetailLevel(Image _image)
{
    int rows = _image.rows();
//    qDebug() << rows;
    int columns = _image.columns();
//    qDebug() << columns;

    _image.modulate(100.0,0.0,0.0);
    _image.threshold(6400);
    _image.negate();
    _image.edge(4.0);

    //Lets try to process image and get the detail level...
    Pixels view(_image);

    double colorSum = 0.0;
    int totalPixels = rows*columns;
//    qDebug() <<"Total pixels: "<< totalPixels;

    PixelPacket *pixels = view.get(0,0,columns,rows);
    for ( int row = 0; row < rows ; ++row )
    for ( int column = 0; column < columns ; ++column )
        colorSum+=(*pixels++).green;
//    qDebug() <<"colorSum: "<< colorSum;

    int res = colorSum/totalPixels/327; //65535/100/2
    qDebug() <<"Detail Level score: "<< (res>35?3:res>15?2:1); //<12 = low ; 12<>35 = med ; >35 = hi

    return (res>35?3:res>15?2:1);
}

Image IM::createResizedVersion(Image _image, int width, int height, MagickCore::FilterTypes filter)
{
    double aspectW = (double)_image.columns()/(double)_image.rows();
    double aspectH = (double)_image.rows()/(double)_image.columns();
//    Geometry fgm = Geometry(width, height);
    Geometry sgm = Geometry(width, height);
    if(width>height*aspectW)sgm = Geometry(width, qCeil(width*aspectH));
    if(height>width*aspectH)sgm = Geometry(qCeil(height*aspectW), height);

    qDebug() << sgm.width() << "x"<<sgm.height();
    Image __image = _image;
    __image.filterType(filter);//MagickCore::HanningFilter);
    __image.zoom(sgm);
    __image.crop(Geometry(width,height,qCeil((sgm.width()-width)/2),qCeil((sgm.height()-height)/2)));
//    if(filter!=MagickCore::BoxFilter&&filter!=MagickCore::PointFilter&&filter!=MagickCore::SincFilter)__image.unsharpmask(0,0.5,1,0.05);//the two last filters are direct scaling filters sharpening those will look bad
    return __image;
}

void IM::saveAs(Image _image, string fileName, int quality)
{
    _image.magick("JPEG");
    _image.quality(quality);
    _image.write(fileName);
}
