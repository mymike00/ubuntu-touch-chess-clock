import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Pickers 1.3
import QtQuick.Window 2.2
import Ubuntu.Layouts 0.1

Tab {
    property bool new_settings: false

    title: i18n.tr("Select time and mode")

    page: Page {
        // Mode picker and label
        Label {
            id: modePickerLabel
            anchors.topMargin: 20
            anchors.top: parent.top
            anchors.left: modePicker.left
            text: i18n.tr("Select mode")
        }
        Picker {
            id: modePicker
            width: modePickerLabel.width
            height: {
                if (parent.height < parent.width) { return parent.height/2 }
                else { return parent.height/4 }
            }
            model: ["Sudden Death","Count Up","Fischer","Hour Glass"]
            anchors.left: datePicker2.right
            anchors.leftMargin: 20
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
            anchors.topMargin: 20
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: 20
            text: i18n.tr("Player 1")
        }
        DatePicker {
            width: parent.width/8
            height: {
                if (parent.height < parent.width) { return parent.height/2 }
                else { return parent.height/4 }
            }
            anchors.top: label_date_player1.bottom
            anchors.leftMargin: 20
            anchors.topMargin: 20
            anchors.left: parent.left
            id: datePicker1
            mode: "Minutes|Seconds"
            onDateChanged: {if (!startup) {
                               new_settings = true;
                           }}
        }

        // Date picker and label for player 2
        Label {
            id: label_date_player2
            anchors.top: parent.top
            anchors.topMargin: 20
            anchors.left: datePicker1.right
            anchors.leftMargin: 20
            text: i18n.tr("Player 2")
        }
        DatePicker {
            width: parent.width/8
            height: {
                if (parent.height < parent.width) { return parent.height/2 }
                else { return parent.height/4 }
            }
            anchors.top: label_date_player2.bottom
            anchors.leftMargin: 20
            anchors.topMargin: 20
            anchors.left: datePicker1.right
            id: datePicker2
            mode: "Minutes|Seconds"
            onDateChanged: {    if (!startup) {
                                    new_settings = true;
                                }
            }
        }

        // Enable new settings button
        Button {
            visible: true
            id: newSettingsButton
            anchors.top: datePicker1.bottom
            anchors.leftMargin: 20
            anchors.topMargin: 20
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
                        mainView.reset()
                        mainView.mode = modePicker.selectedIndex
                        mainView.delay_seconds = datePickerdelay.seconds
                        mainView.delay_minutes = datePickerdelay.minutes
            }
        }

        // Date picker for delay time

        Label {
            id: label_date_delay
            anchors.topMargin: 20
            anchors.left: modePickerLabel.right
            anchors.leftMargin: 20
            text: i18n.tr("Delay")
            visible: modePicker.selectedIndex === 2
            anchors.top: parent.top
        }

        DatePicker {
            id: datePickerdelay
            width: parent.width/8
            anchors.top: label_date_delay.bottom
            anchors.topMargin: 20
            anchors.left: label_date_delay.left
            date: new Date(0,0,0,0,mainView.delay_minutes,mainView.delay_seconds,0)
            mode: "Minutes|Seconds"
            height: {
                if (parent.height < parent.width) { return parent.height/2 }
                else { return parent.height/4 }
            }
            visible: modePicker.selectedIndex === 2
            onDateChanged: {if (!startup) {
                    new_settings = true;
                }}
        }

    }

}

