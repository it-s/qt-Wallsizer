import QtQuick 2.1
import com.Likalo.Drops 1.0


DropZone {
    id: dropTargetArea
    width: 360
    height: 360

    onEntered: {
        if(message.isShown())
            message.hide();
        if(acceptable)
            indicator.show("ACCEPT");
        else
            indicator.show("REJECT");
        if(reason==1)
            message.show(qsTr("Selection contains non image items.\nOnly JPEG and PNG are accepted."));
        if(reason==2)
            message.show(qsTr("The converter does not support more then 12 items at a time."));
    }
    onLeft: {
        console.debug("left");
        indicator.hide();
    }
    onDropped: {
        indicator.hide();
    }

    Grid {
        id: grid
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

                rows: {
                    if(dropTargetArea.count<4)return 1;
                    return Math.ceil(dropTargetArea.count/4);
                }
                columns: {
                    if(dropTargetArea.count<4)return dropTargetArea.count;
                    else return 4;
               }
                Repeater{
                    model: dropTargetArea.urls.length
                    ImageFrame{
                        width: dropTargetArea.width/grid.columns
                        height: width
                        imageSource: dropTargetArea.urls[index]
                        onRemoved: dropTargetArea.removeUrl(index)
                    }
                }
    }
}
