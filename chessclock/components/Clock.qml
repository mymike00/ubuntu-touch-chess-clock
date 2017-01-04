import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Pickers 1.0
import QtSystemInfo 5.0
import QtQuick.Window 2.2
import Ubuntu.Layouts 0.1
import QtMultimedia 5.0
import QtSystemInfo 5.0
import Ubuntu.Components.ListItems 1.0 as ListItem

    Tab {
        title: i18n.tr("Chess clock")

        SoundEffect {
            id: alarm
            source:  {"alarm1.wav"}
        }

        SoundEffect {
            id: click
            source:  {"click.wav"}
        }

        Timer {
            interval: 100; running: true; repeat: true;
            onTriggered: {
                if (!paused) {
                    switch (mainView.mode) {
                    case 0: // sudden death
                        mainView.timeChanged()
                        break
                    case 1: // count up
                        timeChangedCountUp()
                        break
                    case 2: // fischer
                        mainView.timeChanged()
                        break
                    case 3: // hour glass
                        timeChangedHourGlass()
                        break
                    }
                }
                if ( mainView.isGameOver() ) {
                    if (!muted) { alarm.play() }
                }
            }
        }

        page: Page {
            head {
                actions: [
                    Action {
                        objectName: "pauseButton"
                        text: i18n.tr("Pause")
                        iconName: (!paused) ? "media-playback-pause" : "media-playback-start"
                        onTriggered: { paused = !paused;}
                    },
                    Action {
                        text: i18n.tr("Sounds")
                        iconName: (muted) ? "audio-speakers-muted-symbolic" : "audio-speakers-symbolic"
                        onTriggered: { mainView.muted = !mainView.muted }
                    },
                    Action {
                        text: i18n.tr("Reset")
                        iconName: "reset"
                        onTriggered: { mainView.reset() }
                    }
                ]
            }
            Button {
                    anchors.right: parent.right
                    height: parent.height
                    width: parent.width/2
                    color: {
                        if (!finished) {
                            return (is_second_player_timed) ? "darkgray" : "gray"
                        } else {
                            return "#E95420" // from https://design.ubuntu.com/brand/colour-palette
                        }
                    }

                    Text {
                        property string timerText: ""
                        text: {
                                if (second_player_seconds<10) {
                                    if ( mainView.showTenthSecondPlayer() ) {
                                        return second_player_minutes+":0"+second_player_seconds + "<font size=\"6\">"+second_player_tenth+"</font>"
                                    }
                                    return second_player_minutes+":0"+second_player_seconds
                               } else {
                                    if ( mainView.showTenthSecondPlayer() ) {
                                        return second_player_minutes+":"+second_player_seconds + "<font size=\"6\">"+second_player_tenth+"</font>"
                                    }
                               return second_player_minutes+":"+second_player_seconds
                               }
                        }
                        color: "black"
                        anchors.centerIn: parent
                        font.pixelSize: 100
                    }
                    onClicked: {if (mainView.mode === 2 && !paused && is_second_player_timed && !finished) {
                                    second_player_seconds += delay_seconds;
                                    second_player_minutes += delay_minutes;
                                    if ( second_player_seconds >= 60 ) {
                                        second_player_seconds -= 60;
                                        second_player_minutes += 1;
                                    }
                                }
                                if (is_second_player_timed && !muted){ click.play() }
                                is_second_player_timed = false
                                is_first_player_timed = true
                               }
                }
            Button {
                    anchors.left: parent.left
                    height: parent.height
                    width: parent.width/2
                    color: {
                        if (!finished) {
                            return (is_first_player_timed) ? "darkgray" : "gray"
                        } else {
                            return "#E95420" // from https://design.ubuntu.com/brand/colour-palette
                        }
                    }
                    Text {
                        property string timerText: ""
                        property string timerTextTenth: ""
                        text: {
                                if (first_player_seconds<10) {
                                    if ( mainView.showTenthFirstPlayer() ) {
                                        return first_player_minutes+":0"+first_player_seconds + "<font size=\"6\">"+first_player_tenth+"</font>"
                                    }
                                    return first_player_minutes+":0"+first_player_seconds
                               } else {
                                    if ( mainView.showTenthFirstPlayer() ) {
                                        return first_player_minutes+":"+first_player_seconds + "<font size=\"6\">"+first_player_tenth+"</font>"
                                    }
                               return first_player_minutes+":"+first_player_seconds
                               }
                        }
                        color: "black"
                        anchors.centerIn: parent
                        font.pixelSize: 120
                    }
                    onClicked: {if (mainView.mode === 2 && !paused && is_first_player_timed && !finished) {
                                     first_player_seconds += delay_seconds
                                     first_player_minutes += delay_minutes
                                     if ( first_player_seconds >= 60 ) {
                                         first_player_seconds -= 60;
                                         first_player_minutes += 1;
                                     }
                                 }
                                if (is_first_player_timed && !muted){ click.play() }
                                is_first_player_timed = false
                                is_second_player_timed = true
                                }
                }
        }


    }
