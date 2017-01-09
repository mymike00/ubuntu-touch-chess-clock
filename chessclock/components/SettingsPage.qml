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
import Ubuntu.Components.Pickers 1.3
import QtQuick.Window 2.2
import Ubuntu.Layouts 0.1
import Ubuntu.Components.ListItems 1.3
import QtSystemInfo 5.0
import Qt.labs.settings 1.0

    Page {
        width: bottomEdge.width
        height: bottomEdge.height
        //property var model: null
        property bool new_settings: false
        //signal bottomEdgeClosed()
        header: PageHeader {

            id: standardHeader
            title: i18n.tr("Settings")
            leadingActionBar.actions: [
                Action {
                    text: "close"
                    iconName: "go-down"
                    onTriggered: {
                        bottomEdge.collapse()
                    }
                }
            ]

            trailingActionBar.actions: [
                Action {
                    id: infoAction
                    objectName: "infoButton"
                    text: i18n.tr("Information")
                    iconName: "help"
                    onTriggered: {
                        mainStack.push(Qt.resolvedUrl("InfoPage.qml"))
                    }
                },
                Action {
                    objectName: "pauseButton"
                    visible: false
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
                    visible: false
                    iconName: "reset"
                    onTriggered: { mainView.reset() }
                },
                Action {
                    text: i18n.tr("About")
                    iconName: "info"
                    onTriggered: { mainStack.push(Qt.resolvedUrl("AboutPage.qml")) }
                }
            ]
        }
        Rectangle {
            anchors.fill: parent
            anchors.top: standardHeader.bottom
            anchors.topMargin: units.gu(8)
            // Mode picker and label
            Label {
                id: modePickerLabel
                anchors.top: parent.top

                anchors.left: modePicker.left
                text: i18n.tr("Mode")
            }
            Picker {
                id: modePicker
                width: parent.width/8
                height: parent.height/2

                model: [i18n.tr("Sudden Death"),
                        i18n.tr("Count Up"),
                        i18n.tr("Fischer"),
                        i18n.tr("Hour Glass"),
                        i18n.tr("Bronstein Delay")]
                anchors.left: datePicker2.right
                anchors.leftMargin: units.gu(1)
                anchors.top: datePicker2.top
                delegate: PickerDelegate {
                    Label {
                        anchors.left: parent.left
                        anchors.centerIn: parent
                        text: modelData
                        textSize: Label.XSmall
                    }
                }
                selectedIndex: 1
                onSelectedIndexChanged: {
                    new_settings = true
                }
            }

            // Date picker and label for player 1
            Label {
                id: label_date_player1
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.leftMargin: units.gu(1)
                text: i18n.tr("Player 1")
            }
            DatePicker {
                width: parent.width/8
                height: parent.height/2
                anchors.top: label_date_player1.bottom
                anchors.leftMargin: units.gu(1)
                anchors.topMargin: units.gu(1)
                anchors.left: parent.left
                id: datePicker1
                mode: "Minutes|Seconds"
                onDateChanged: {
                                   new_settings = true;
                               }
            }

            // Date picker and label for player 2
            Label {
                id: label_date_player2
                anchors.top: parent.top
                anchors.left: datePicker1.right
                anchors.leftMargin: units.gu(1)
                text: i18n.tr("Player 2")
            }
            DatePicker {
                width: parent.width/8
                height: parent.height/2
                anchors.top: label_date_player2.bottom
                anchors.topMargin: units.gu(1)
                anchors.leftMargin: units.gu(1)
                anchors.left: datePicker1.right
                id: datePicker2
                mode: "Minutes|Seconds"
                onDateChanged: {
                                        new_settings = true;

                }
            }

            // Enable new settings button
            Button {
                visible: true
                id: newSettingsButton
                anchors.top: datePicker1.bottom
                anchors.leftMargin: units.gu(1)
                anchors.topMargin: units.gu(1)
                anchors.left: parent.left
                text: i18n.tr("Set clock")
                color: (new_settings) ? "green" : "gray"
                onClicked: {new_settings = false;
                            mainView.initial_first_player_minutes = datePicker1.minutes;
                            mainView.initial_first_player_seconds = datePicker1.seconds;
                            mainView.initial_second_player_minutes = datePicker2.minutes;
                            mainView.initial_second_player_seconds = datePicker2.seconds;
                            mainView.finished = false;
                            mainView.is_first_player_timed = false;
                            mainView.is_second_player_timed = false;
                            mainView.paused = false;
                            mainView.mode = modePicker.selectedIndex
                            mainView.delay_seconds = datePickerdelay.seconds
                            mainView.delay_minutes = datePickerdelay.minutes
                            mainView.reset()
                }
            }

            // Date picker for delay time

            Label {
                id: label_date_delay
                anchors.left: modePicker.right
                anchors.leftMargin: units.gu(1)
                text: i18n.tr("Delay")
                visible: modePicker.selectedIndex === 2 || modePicker.selectedIndex === 4
                anchors.top: parent.top
            }

            DatePicker {
                id: datePickerdelay
                width: parent.width/8
                anchors.top: label_date_delay.bottom
                anchors.topMargin: units.gu(1)
                anchors.left: label_date_delay.left
                mode: "Minutes|Seconds"
                height: parent.height/2
                visible: modePicker.selectedIndex === 2 || modePicker.selectedIndex === 4
                onDateChanged: {
                        new_settings = true;
                    }
            }
        }

    }



