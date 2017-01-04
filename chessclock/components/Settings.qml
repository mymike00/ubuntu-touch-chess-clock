import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Pickers 1.3
import QtQuick.Window 2.2
import Ubuntu.Layouts 0.1
import Ubuntu.Components.ListItems 1.3 as ListItem
import Ubuntu.Components.Popups 1.3

Tab {
    property bool new_settings: false

    title: i18n.tr("Select time and mode")

    page: Page {
        // Info popover
            Component {
                id: popoverComponent
                Popover {
                    id: popover
                    Column {
                        id: containerLayout
                        anchors {
                            left: parent.left
                            top: parent.top
                            right: parent.right
                        }
                        ListItem.Header { text: "About time controls" }
                        ListItem.Standard { text: "Sudden Death"; onClicked: PopupUtils.open(infoSuddenDeath) }
                        ListItem.Standard { text: "Count Up"; onClicked: PopupUtils.open(infoCountUp) }
                        ListItem.Standard { text: "Fischer"; onClicked: PopupUtils.open(infoFischer) }
                        ListItem.Standard { text: "Hour Glass"; onClicked: PopupUtils.open(infoHourGlass) }
                        ListItem.Standard {
                            onClicked: Qt.openUrlExternally("https://en.wikipedia.org/wiki/Chess_clock")
                            Text {
                                anchors.centerIn: parent
                                text: "More on chess clocks..."
                                color: "gray"
                            }
                        }
                    }
                }
            }
        Item {
            id: popupLocation
            x: parent.width
            y: 0
        }

        // Head with info action
        head {
            actions: [
                Action {
                    id: infoAction
                    objectName: "infoButton"
                    text: i18n.tr("Information")
                    iconName: "info"
                    onTriggered: {PopupUtils.open(popoverComponent,popupLocation)}
                }
            ]
        }
        // The information about the different time controls are downloaded from https://en.wikipedia.org/wiki/Time_control
        // and https://en.wikipedia.org/wiki/Chess_clock
        // Info popover for sudden death
        Component {
             id: infoSuddenDeath
             Dialog {
                 id: dialogSuddenDeath
                 title: "Sudden Death"
                 text: "This is the simplest methodology. Each player is assigned a fixed amount of time for the"+
                       "whole game: once a player's main time expires, he loses the game."
                 Button {
                     text: "That was simple!"
                     onClicked: PopupUtils.close(dialogSuddenDeath)
                 }
             }
        }
        // Info popover for hour glass
        Component {
             id: infoHourGlass
             Dialog {
                 id: dialogHourGlass
                 title: "Hour Glass"
                 text: "A player loses in this time control when they allow the difference between both clocks"+
                       "to reach the specified total amount. For example, if the total is defined as one minute,"+
                       "both players start their clocks at thirty seconds. Every second the first player uses"+
                       "to think in their moves is subtracted from their clock and added to their opponent's"+
                       "clock. If they use thirty seconds to move, the difference between the clocks reaches"+
                       "one minute, and the time flag falls to indicate that they lose by time. If they have"+
                       "used twenty nine seconds and then push the clock's button, they have one second left on"+
                       "their clock and their opponent has fifty-nine seconds."
                 Button {
                     text: "Ok, got it!"
                     onClicked: PopupUtils.close(dialogHourGlass)
                 }
             }
        }
        // Info popover for Fischer
        Component {
             id: infoFischer
             Dialog {
                 id: dialogFischer
                 title: "Hour Glass"
                 text: "Before a player has made their move, a specified time increment is added to their clock."+
                       "Time can be accumulated, so if the player moves within the delay period, their remaining"+
                       "time actually increases. For example, if the delay time is five seconds, and a player"+
                       "has four seconds left on their clock, as soon as their opponent moves, they receive the"+
                       "increment and has nine seconds to make a move. If they take two seconds to move, on the"+
                       "start of their next move they have twelve seconds."
                 Button {
                     text: "I understand!"
                     onClicked: PopupUtils.close(dialogFischer)
                 }
             }
        }
        // Info popover for count up
        Component {
             id: infoCountUp
             Dialog {
                 id: dialogCountUp
                 title: "Count Up"
                 text: "In this time control the total time used for each of the players are recorded."
                 Button {
                     text: "Is that all?"
                     onClicked: PopupUtils.close(dialogCountUp)
                 }
             }
        }

        // Mode picker and label
        Label {
            id: modePickerLabel
            anchors.topMargin: 20
            anchors.top: parent.top
            anchors.left: modePicker.left
            text: i18n.tr("Mode")
        }
        Picker {
            id: modePicker
            width: parent.width/8
            height: {
                if (parent.height < parent.width) { return parent.height/2 }
                else { return parent.height/4 }
            }
            model: ["Sudden Death","Count Up","Fischer","Hour Glass"] // i18n.tr() is not used on purpose
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
            onDateChanged: {
                               new_settings = true;
                           }
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
            onDateChanged: {
                                    new_settings = true;

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
            anchors.left: modePicker.right
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
            onDateChanged: {
                    new_settings = true;
                }
        }

    }

}

