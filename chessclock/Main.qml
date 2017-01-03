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

    Tabs {
        Clock {
            id: clockPage
        }
        Settings {
            id: settingsPage
        }
        About {
            id: aboutPage
        }
    }
}
