import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Pickers 1.0
import QtQuick.Window 2.2
import Ubuntu.Layouts 0.1
import Ubuntu.Components.ListItems 1.3
// Used for compiling on desktop
//import "components"
//import "resources"

MainView {
    id : mainView
    applicationName: "chessclock.jonas"
    automaticOrientation: false
    width: units.gu(100)
    height: units.gu(75)

    property real margins: units.gu(2)
    property real buttonWidth: units.gu(9)

    property int first_player_minutes: 5
    property int first_player_seconds: 0
    property int first_player_tenth: 0
    property int second_player_minutes: 5
    property int second_player_seconds: 0
    property int second_player_tenth: 0
    property int initial_first_player_minutes: 5
    property int initial_first_player_seconds: 0
    property int initial_second_player_minutes: 5
    property int initial_second_player_seconds: 0
    property int delay_seconds: 5
    property int delay_minutes: 0
    property bool is_first_player_timed: false
    property bool is_second_player_timed: false
    property bool paused: false
    property bool finished: false
    property int mode: 0 // 0: sudden death, 1: count up, 2: fischer, 3: hour glass
    property bool muted: false

    function firstPlayerCountDown() {
        if (first_player_tenth == 0) {
                        first_player_tenth = 9;
                        if (first_player_seconds == 0) {
                            first_player_seconds = 59;
                            first_player_minutes -= 1
                        } else {
                            first_player_seconds -= 1
                        }
                    } else {
                        first_player_tenth -= 1
                    }
    }

    function secondPlayerCountDown() {
        if (second_player_tenth == 0) {
                        second_player_tenth = 9;
                        if (second_player_seconds == 0) {
                            second_player_seconds = 59;
                            second_player_minutes -= 1
                        } else {
                            second_player_seconds -= 1
                        }
                    } else {
                        second_player_tenth -= 1
                    }
    }

    function timeChanged() {
        if (is_first_player_timed) {
            if ((second_player_seconds<=0 && second_player_minutes<=0 && second_player_tenth <= 0)
                    || (first_player_seconds<=0 && first_player_minutes<=0 && first_player_tenth <=0)) {
                finished = true
            } else { firstPlayerCountDown() }
        } else if (is_second_player_timed) {
            if ((second_player_seconds<=0 && second_player_minutes<=0 && second_player_tenth <= 0)
                    || (first_player_seconds<=0 && first_player_minutes<=0 && first_player_tenth <=0)) {
                finished = true
            } else { secondPlayerCountDown() }
        }
    }

    function firstPlayerCountUp() {
        if (first_player_tenth == 9) {
            first_player_tenth = 0;
            if (first_player_seconds == 59) {
                first_player_seconds = 0
                first_player_minutes += 1
            } else {
                first_player_seconds += 1
            }
        } else {
            first_player_tenth += 1
        }
    }

    function secondPlayerCountUp() {
        if (second_player_tenth == 9) {
            second_player_tenth = 0;
            if (second_player_seconds == 59) {
                second_player_seconds = 0
                second_player_minutes += 1
            } else {
                second_player_seconds += 1
            }
        } else {
            second_player_tenth += 1
        }
    }

    function timeChangedCountUp() {
        if (is_first_player_timed) {
            firstPlayerCountUp()
        } else if (is_second_player_timed) {
            secondPlayerCountUp()
        }
    }

    function timeChangedHourGlass() {
        if ((second_player_seconds<=0 && second_player_minutes<=0 && second_player_tenth <= 0)
                || (first_player_seconds<=0 && first_player_minutes<=0 && first_player_tenth <=0)) {
            finished = true
        }
        else if (is_first_player_timed) {
                    firstPlayerCountDown()
                    secondPlayerCountUp()
             }
        else if (is_second_player_timed) {
            firstPlayerCountUp()
            secondPlayerCountDown()
        }
    }

    function reset () {
        mainView.first_player_minutes = initial_first_player_minutes;
        mainView.first_player_seconds = initial_first_player_seconds;
        mainView.second_player_minutes = initial_second_player_minutes;
        mainView.second_player_seconds = initial_second_player_seconds;
        mainView.second_player_tenth = 0
        mainView.first_player_tenth = 0
        mainView.finished = false;
        mainView.is_first_player_timed = false;
        mainView.is_second_player_timed = false;
        mainView.paused = false;
    }

    function showTenthFirstPlayer () {
        return (first_player_minutes<=0 && first_player_seconds <= 20 && mode !== 1)
    }

    function showTenthSecondPlayer () {
        return (second_player_minutes<=0 && second_player_seconds <= 20 && mode !== 1)
    }

    function isGameOver() {
        return ( !finished &&

                    ( (first_player_seconds == 0 && first_player_minutes == 0 && first_player_tenth == 0)   ||
                        (second_player_seconds == 0 && second_player_minutes == 0 && second_player_tenth == 0) ) &&
                is_first_player_timed != is_second_player_timed &&
                mode !== 1

                )

    }

    Tabs {
        id: tabs

        Clock {
            id: clockTab
        }
        Settings {
            id: settingsTab
        }
        About {
            id: aboutTab
        }
    }
}
