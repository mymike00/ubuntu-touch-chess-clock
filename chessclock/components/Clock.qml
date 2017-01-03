import QtQuick 2.4
import Ubuntu.Components 1.2
import Ubuntu.Components.Pickers 1.0
import QtQuick.Window 2.2
import Ubuntu.Layouts 0.1
    Tab {
        title: i18n.tr("Chess clock")

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
