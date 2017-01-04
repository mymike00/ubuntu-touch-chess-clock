import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Pickers 1.3
import QtQuick.Window 2.2
import Ubuntu.Layouts 0.1

Tab {
    property bool new_settings: false
    // For some reason, the onDateChanged is toggled on creation.
    // The following property is used to "fix" this. It is quite
    // ugly, but it works.
    property bool startup: true

    title: i18n.tr("Select time and mode")

    page: Page {

        // Checkbox and label for Fischer mode
        Switch {
            id: checkboxFischer
            anchors.top: checkboxCountUp.bottom
            Label {
                text: i18n.tr("Fischer")
                anchors.left: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 10
            }
            anchors.topMargin: parent.height/10
            anchors.left: datePicker2.right
            anchors.leftMargin: parent.width/30
            checked: mainView.fischer
            onCheckedChanged: {
                                new_settings = true;
                                if (checkboxCountUp.checked) {
                                    if (checkboxFischer.checked) {
                                        checkboxCountUp.checked = false;
                                    }
                                }
                              }
        }

        // Date picker and label for delay time
        Label {
            id: label_date_delay
            anchors.topMargin: 20
            anchors.left: checkboxCountUp.left
            anchors.leftMargin: 20
            text: i18n.tr("Delay")
            visible: checkboxFischer.checked
            anchors.top: checkboxFischer.bottom
        }
        DatePicker {
            id: datePickerdelay
            width: parent.width/8
            anchors.top: label_date_delay.bottom
            anchors.leftMargin: 20
            anchors.topMargin: 20
            anchors.left: checkboxCountUp.left
            date: new Date(0,0,0,0,mainView.delay_minutes,mainView.delay_seconds,0)
            mode: "Minutes|Seconds"
            height: parent.height/4
            visible: checkboxFischer.checked // visible only for certain modes
            onDateChanged: {if (!startup) {
                    new_settings = true;
                }}
            // For some reason, the onDateChanged is toggled on creation.
            // The following property is used to "fix" its implications.
            // It is quite ugly, but it works.
            onActiveFocusChanged: startup = false;
        }

        // Checkbox for count up mode
        Switch {
            id: checkboxCountUp
            anchors.top: parent.top
            Label {
                text: i18n.tr("Count up")
                anchors.left: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 10
            }
            anchors.topMargin: parent.height/10
            anchors.left: datePicker2.right
            anchors.leftMargin: parent.width/30
            checked: mainView.countUp
            onCheckedChanged: {
                                new_settings = true;
                                if (checkboxFischer.checked) {
                                    if (checkboxCountUp.checked) {
                                        checkboxFischer.checked = false;
                                    }
                                }
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
            anchors.top: label_date_player1.bottom
            anchors.leftMargin: 20
            anchors.topMargin: 20
            anchors.left: parent.left
            //date: new Date(0,0,0,0,first_player_minutes,first_player_seconds,0)
            id: datePicker1
            mode: "Minutes|Seconds"
            onDateChanged: {if (!startup) {
                               new_settings = true;
                           }}
            // For some reason, the onDateChanged is toggled on creation.
            // The following property is used to "fix" its implications.
            // It is quite ugly, but it works.
            onActiveFocusChanged: startup = false;
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
            anchors.top: label_date_player2.bottom
            anchors.leftMargin: 20
            anchors.topMargin: 20
            anchors.left: datePicker1.right
            //date: new Date(0,0,0,0,first_player_minutes,first_player_seconds,0)
            id: datePicker2
            mode: "Minutes|Seconds"
            onDateChanged: {    if (!startup) {
                                    new_settings = true;
                                }
            }
            // For some reason, the onDateChanged is toggled on creation.
            // The following property is used to "fix" its implications.
            // It is quite ugly, but it works.
            onActiveFocusChanged: startup = false;
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
                        mainView.fischer = checkboxFischer.checked;
                        mainView.countUp = checkboxCountUp.checked;
                        mainView.reset()}
        }

    }

}

