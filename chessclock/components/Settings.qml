import QtQuick 2.4
import Ubuntu.Components 1.2
import Ubuntu.Components.Pickers 1.0
import QtQuick.Window 2.2
import Ubuntu.Layouts 0.1

Tab {
    property int first_player_minutes: 10
    property int first_player_seconds: 0
    property int delay_seconds: 10
    property int delay_minutes: 0
    property int second_player_minutes: 10
    property int second_player_seconds: 0
    property bool countUp: false
    property bool fischer: false
    property bool new_settings: false
    // For some reason, the onDateChanged is toggled on creation.
    // The following property is used to "fix" this. It is quite
    // ugly, but it works.
    property bool startup: true

    title: i18n.tr("Select time and mode")

    page: Page {

        // Checkbox and label for Fischer mode
        CheckBox {
            id: checkboxFischer
            anchors.top: checkboxCountUp.bottom
            Label {
                text: i18n.tr("Fischer")
                anchors.left: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 10
            }
            anchors.topMargin: parent.height/10
            anchors.left: datePicker2.right
            anchors.leftMargin: parent.width/30
            checked: fischer
            onCheckedChanged: { fischer = checkboxFischer.checked;
                                new_settings = true;
                                if (countUp) {
                                    if (fischer) {
                                        checkboxCountUp.checked = false;
                                        countUp = false;
                                    }
                                }
                              }
        }
        Label {
            id: label_date_delay
            anchors.topMargin: 20
            anchors.left: checkboxCountUp.left
            anchors.leftMargin: 20
            text: i18n.tr("Delay")
            visible: fischer
            anchors.top: checkboxFischer.bottom
        }

        // Date picker for delay time
        DatePicker {
            id: datePickerdelay
            width: parent.width/8
            anchors.top: label_date_delay.bottom
            anchors.leftMargin: 20
            anchors.topMargin: 20
            anchors.left: checkboxCountUp.left
            date: new Date(0,0,0,0,delay_minutes,delay_seconds,0)
            mode: "Minutes|Seconds"
            height: parent.height/4
            visible: fischer // visible only for certain modes
            onDateChanged: {if (!startup) {
                    new_settings = true;
                }}
            // For some reason, the onDateChanged is toggled on creation.
            // The following property is used to "fix" its implications.
            // It is quite ugly, but it works.
            onActiveFocusChanged: startup = false;
        }

        // Checkbox for count up mode
        CheckBox {
            id: checkboxCountUp
            anchors.top: parent.top
            Label {
                text: i18n.tr("Count up")
                anchors.left: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 10
            }
            anchors.topMargin: parent.height/10
            anchors.left: datePicker2.right
            anchors.leftMargin: parent.width/30
            checked: countUp
            onCheckedChanged: { countUp = checkboxCountUp.checked;
                                new_settings = true;
                                if (fischer) {
                                    if (countUp) {
                                        checkboxFischer.checked = false;
                                        fischer = false;
                                    }
                                }
                               }
        }

        // Date picker and label for player 1
        Label {
            id: label_date_player1
            anchors.topMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 20
            text: i18n.tr("Player 1" + startup)
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
            anchors.topMargin: 20
            anchors.left: datePicker1.right
            anchors.leftMargin: 20
            text: i18n.tr("Player 2" + new_settings)
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
            text: "Use new settings"
            color: (new_settings) ? "green" : "gray"
            onClicked: {new_settings = false;
                        mainView.first_player_minutes = datePicker1.minutes;
                        mainView.first_player_seconds = datePicker1.seconds;
                        mainView.second_player_minutes = datePicker2.minutes;
                        mainView.second_player_seconds = datePicker2.seconds;}
        }

    }
}

