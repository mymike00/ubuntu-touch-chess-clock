/*
 * Copyright (C) 2017 Jonas Tjemsland
 *
 * This file is part of the Ubuntu Chess Clock.
 *
 * Ubuntu Chess Clock is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 3 as
 * published by the Free Software Foundation.
 *
 * Ubuntu Chess Clock is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Pickers 1.0
import QtSystemInfo 5.0
import QtQuick.Window 2.2
import Ubuntu.Layouts 0.1
import QtMultimedia 5.0
import QtSystemInfo 5.0
import Ubuntu.Components.ListItems 1.0 as ListItem

    Page {
        Rectangle {
            anchors.fill: parent
            color: "black"
        }

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
                    case 4: // Bronstein
                        timeChangedBronstein()
                        break
                    }
                }
                if ( mainView.isGameOver() ) {
                    if (!muted) { alarm.play() }
                }
            }
        }

        header:PageHeader {visible: false}

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
                        font.pixelSize: 120
                    }
                    onClicked: {if (mainView.mode === 2 && !paused && is_second_player_timed && !finished) {
                                    second_player_seconds += delay_seconds;
                                    second_player_minutes += delay_minutes;
                                    if ( second_player_seconds >= 60 ) {
                                        second_player_seconds -= 60;
                                        second_player_minutes += 1;
                                    }
                                } else if (mainView.mode === 4 && !paused && is_second_player_timed && !finished) {
                                    if (mainView.delay_left <= 0) {
                                        second_player_seconds += delay_seconds
                                        second_player_minutes += delay_minutes
                                    } else {
                                        second_player_seconds = bronstein_start_seconds_second_player
                                        second_player_minutes = bronstein_start_minutes_second_player
                                        second_player_tenth = bronstein_start_tenth_second_player
                                    }

                                    mainView.delay_left = mainView.delay_seconds*10 + mainView.delay_minutes*600
                                    if ( second_player_seconds >= 60 ) {
                                        second_player_seconds -= 60;
                                        second_player_minutes += 1;
                                    }
                                    bronstein_start_seconds_first_player = first_player_seconds
                                    bronstein_start_minutes_first_player = first_player_minutes
                                    bronstein_start_tenth_first_player = first_player_tenth
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
                                 } else if (mainView.mode === 4 && !paused && is_first_player_timed && !finished) {
                                    if (mainView.delay_left <= 0) {
                                        first_player_seconds += delay_seconds
                                        first_player_minutes += delay_minutes
                                    } else {
                                        first_player_seconds = bronstein_start_seconds_first_player
                                        first_player_minutes = bronstein_start_minutes_first_player
                                        first_player_tenth = bronstein_start_tenth_first_player
                                    }

                                    mainView.delay_left = mainView.delay_seconds*10 + mainView.delay_minutes*600
                                    if ( first_player_seconds >= 60 ) {
                                        first_player_seconds -= 60;
                                        first_player_minutes += 1;
                                    }

                                    bronstein_start_seconds_second_player = second_player_seconds
                                    bronstein_start_minutes_second_player = second_player_minutes
                                    bronstein_start_tenth_second_player = second_player_tenth
                                }
                                if (is_first_player_timed && !muted){ click.play() }
                                is_first_player_timed = false
                                is_second_player_timed = true
                                }

                }
            ClockHeader {id: clockHeader}

        }
