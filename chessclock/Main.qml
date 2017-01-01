import QtQuick 2.4
import Ubuntu.Components 1.2
import Ubuntu.Components.Pickers 1.0
import QtQuick.Window 2.2
import Ubuntu.Layouts 0.1

MainView {
    id : mainView
    applicationName: "chessclock.jonas"
    width: units.gu(100)
    height: units.gu(75)

    property real margins: units.gu(2)
    property real buttonWidth: units.gu(9)

    property int first_player_minutes: 10
    property int first_player_seconds: 0
    property int delay_seconds: 10
    property int delay_minutes: 0
    property int second_player_minutes: 10
    property int second_player_seconds: 0
    property bool is_first_player_timed: false
    property bool is_second_player_timed: false
    property bool paused: false
    property bool finished: false
    property bool countUp: false
    property bool fischer: false

    function timeChanged() {
        if (is_first_player_timed) {
            if ((second_player_seconds<=0 && second_player_minutes<=0)
                    || (first_player_seconds<=0 && first_player_minutes<=0)) {
                finished = true
            } else if (first_player_seconds == 0) {
                first_player_seconds = 59;
                first_player_minutes = first_player_minutes - 1;
            } else {
                first_player_seconds = first_player_seconds - 1;
            }
        } else if (is_second_player_timed) {
            if ((second_player_seconds<=0 && second_player_minutes<=0)
                    || (first_player_seconds<=0 && first_player_minutes<=0)) {
                finished = true
            } else if (second_player_seconds == 0) {
                second_player_seconds = 59;
                second_player_minutes = second_player_minutes - 1;
            } else {
                second_player_seconds = second_player_seconds - 1;
            }
        }
    }

    function timeChangedCountUp() {
        if (is_first_player_timed) {
            if (first_player_seconds == 59) {
                first_player_seconds = 0;
                first_player_minutes = first_player_minutes + 1;
            } else {
                first_player_seconds = first_player_seconds + 1;
            }
        } else if (is_second_player_timed) {
            if (second_player_seconds == 59) {
                second_player_seconds = 0;
                second_player_minutes = second_player_minutes + 1;
            } else {
                second_player_seconds = second_player_seconds + 1;
            }
        }
    }

    Button {
        id: pauseButton
        anchors.right: parent.right
        text: "II"
        visible: !paused && (is_first_player_timed || is_second_player_timed) && !finished
        width: parent.width/15
        onClicked: { paused = !paused }
    }
    Button {
        id: playButton
        anchors.right: parent.right
        text: ">"
        visible: paused && (is_first_player_timed || is_second_player_timed) && !finished
        color: "green"
        width: parent.width/15
        onClicked: { paused = !paused}
    }

    Timer {
        interval: 1000; running: true; repeat: true;
        onTriggered: if (!paused && !countUp) { mainView.timeChanged() }
                     else if (!paused && countUp) { mainView.timeChangedCountUp() }
    }
    Tabs {
        Tab {
            title: i18n.tr("Chess clock")
            onActiveChanged: { first_player_seconds = datePicker1.seconds;
                               first_player_minutes = datePicker1.minutes;
                               second_player_seconds = datePicker2.seconds;
                               second_player_minutes = datePicker2.minutes;
                               delay_seconds = datePickerdelay.seconds;
                               delay_minutes =
                               is_first_player_timed = false;
                               is_second_player_timed = false;
                               finished = false;
                               paused = false; }
            page: Page {
                Button {
                        anchors.right: parent.right
                        height: parent.height
                        width: parent.width/2
                        color: (is_second_player_timed) ? "darkgray" : "gray"
                        Text {
                            text: {if (second_player_seconds<10) {
                                    return second_player_minutes+":0"+second_player_seconds
                                   } else {
                                    return second_player_minutes+":"+second_player_seconds
                                   }
                            }
                            color: "black"
                            anchors.centerIn: parent
                            font.pixelSize: 100
                        }
                        onClicked: {if (fischer && !paused && is_second_player_timed && !finished) {
                                        second_player_seconds += delay_seconds
                                        second_player_minutes += delay_minutes
                                        if ( second_player_seconds >= 60 ) {
                                            second_player_seconds -= 60;
                                            second_player_minutes += 1;
                                        }
                                    }
                                    is_second_player_timed = false
                                    is_first_player_timed = true
                                   }
                    }
                Button {
                        anchors.left: parent.left
                        height: parent.height
                        width: parent.width/2
                        color: (is_first_player_timed) ? "darkgray" : "gray"
                        Text {
                            text: {if (first_player_seconds<10) {
                                    return first_player_minutes+":0"+first_player_seconds
                                   } else {
                                    return first_player_minutes+":"+first_player_seconds
                                   }
                            }
                            color: "black"
                            anchors.centerIn: parent
                            font.pixelSize: 120
                        }
                        onClicked: {if (fischer && !paused && is_first_player_timed && !finished) {
                                         first_player_seconds += delay_seconds
                                         first_player_minutes += delay_minutes
                                         if ( first_player_seconds >= 60 ) {
                                             first_player_seconds -= 60;
                                             first_player_minutes += 1;
                                         }
                                     }
                                    is_first_player_timed = false
                                    is_second_player_timed = true
                                    }
                    }
            }
        }
        Tab {
            title: i18n.tr("Select time and mode")
            page: Page {
                Label {
                    id: label_date_delay
                    anchors.topMargin: 20
                    anchors.left: checkboxCountUp.left
                    anchors.leftMargin: 20
                    text: "Delay"
                    visible: fischer
                    anchors.top: checkboxFischer.bottom
                }
                DatePicker {
                    width: parent.width/8
                    anchors.top: label_date_delay.bottom
                    anchors.leftMargin: 20
                    anchors.topMargin: 20
                    anchors.left: checkboxCountUp.left
                    date: new Date(0,0,0,0,delay_minutes,delay_seconds,0)
                    id: datePickerdelay
                    mode: "Minutes|Seconds"
                    height: parent.height/4
                    visible: fischer
                }
                CheckBox {
                    id: checkboxCountUp
                    anchors.top: parent.top
                    Label {
                        text: "Count up"
                        anchors.left: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 10
                    }
                    anchors.topMargin: parent.height/10
                    anchors.left: datePicker2.right
                    anchors.leftMargin: parent.width/30
                    checked: countUp
                    onCheckedChanged: { countUp = checkboxCountUp.checked;
                                        if (fischer) {
                                            if (countUp) {
                                                checkboxFischer.checked = false;
                                                fischer = false;
                                            }
                                        }
                                       }
                }
                CheckBox {
                    id: checkboxFischer
                    anchors.top: checkboxCountUp.bottom
                    Label {
                        text: "Fischer"
                        anchors.left: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 10
                    }
                    anchors.topMargin: parent.height/10
                    anchors.left: datePicker2.right
                    anchors.leftMargin: parent.width/30
                    checked: fischer
                    onCheckedChanged: { fischer = checkboxFischer.checked;
                                        if (countUp) {
                                            if (fischer) {
                                                checkboxCountUp.checked = false;
                                                countUp = false;
                                            }
                                        }
                                      }
                }
                Label {
                    id: label_date_player1
                    anchors.topMargin: 20
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    text: "Player 1"
                }
                DatePicker {
                    width: parent.width/8
                    anchors.top: label_date_player1.bottom
                    anchors.leftMargin: 20
                    anchors.topMargin: 20
                    anchors.left: parent.left
                    date: new Date(0,0,0,0,first_player_minutes,first_player_seconds,0)
                    id: datePicker1
                    mode: "Minutes|Seconds"
                }
                Label {
                    id: label_date_player2
                    anchors.topMargin: 20
                    anchors.left: datePicker1.right
                    anchors.leftMargin: 20
                    text: "Player 2"
                }
                DatePicker {
                    width: parent.width/8
                    anchors.top: label_date_player2.bottom
                    anchors.leftMargin: 20
                    anchors.topMargin: 20
                    anchors.left: datePicker1.right
                    date: new Date(0,0,0,0,first_player_minutes,first_player_seconds,0)
                    id: datePicker2
                    mode: "Minutes|Seconds"
                }
            }
        }
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
                    text: " <p><b>Author:</b> Jonas Tjemsland </p>
                            <p><b>Contact:</b> jonas.tjemsland@gmail.com </p>
                            <p><b>Website:</b> <font size=\"8\"><a href=\"https://github.com/tjemsland/ubuntu-touch-chess-clock\">github.com/tjemsland/ubuntu-touch-chess-clock</a></font> </p>
                            <p><b>Version:</b> 1.0 </p>
                            <p><b>Date:</b> January 1, 2017 </p>"
                }
            }
        }
    }
}
