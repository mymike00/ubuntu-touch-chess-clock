import QtQuick 2.4
import Ubuntu.Components 1.2
import Ubuntu.Components.Pickers 1.0
import QtQuick.Window 2.2
import Ubuntu.Layouts 0.1

Tab {
    title: i18n.tr("About")
    page: Page {
        UbuntuShape {
            Layouts.item: "icon"
            property real maxWidth: units.gu(45)
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.height/3
            height: parent.height/3
            image: Image {
                objectName: "aboutImage"
                source: "chessclock.png"
                smooth: true
                fillMode: Image.PreserveAspectFit
            }
        }
        Label {
            id: contactText
            y: parent.height/3
            x: parent.width/20
            text: " <p><b>"+i18n.tr("Author:")+"</b> Jonas Tjemsland </p>
                    <p><b>"+i18n.tr("Contact:")+"</b> jonas.tjemsland@gmail.com </p>
                    <p><b>"+i18n.tr("Website:")+"</b> <font size=\"8\"><a href=\"https://github.com/tjemsland/ubuntu-touch-chess-clock\">github.com/tjemsland/ubuntu-touch-chess-clock</a></font> </p>
                    <p><b>"+i18n.tr("Version:")+"</b> 1.0 </p>
                    <p><b>"+i18n.tr("Date:")+"</b> January 1, 2017 </p>"
        }
    }
}
