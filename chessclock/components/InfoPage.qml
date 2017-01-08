import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Pickers 1.3
import QtQuick.Window 2.2
import Ubuntu.Layouts 0.1
import Ubuntu.Components.ListItems 1.3 as ListItem
import Ubuntu.Components.Popups 1.3

Page {

    header: PageHeader {
        title: i18n.tr("About time controls")
        flickable: settingsPlugin
    }

    Flickable {
        id: settingsPlugin
        contentHeight: _settingsColumn.height
        anchors.fill: parent

        Column {
            id: _settingsColumn

            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }
            ListItem.Standard { text: i18n.tr("Sudden Death"); onClicked: PopupUtils.open(infoSuddenDeath) }
            ListItem.Standard { text: i18n.tr("Count Up"); onClicked: PopupUtils.open(infoCountUp) }
            ListItem.Standard { text: i18n.tr("Fischer"); onClicked: PopupUtils.open(infoFischer) }
            ListItem.Standard { text: i18n.tr("Hour Glass"); onClicked: PopupUtils.open(infoHourGlass) }
            ListItem.Standard { text: i18n.tr("Bronstein"); onClicked: PopupUtils.open(infoBronstein) }
            ListItem.Standard {
                onClicked: Qt.openUrlExternally(i18n.tr("https://en.wikipedia.org/wiki/Chess_clock"))
                Text {
                    anchors.centerIn: parent
                    text: i18n.tr("More on chess clocks...")
                    color: "gray"
                }
            }
        }
    }


    // The information about the different time controls are downloaded from https://en.wikipedia.org/wiki/Time_control
    // and https://en.wikipedia.org/wiki/Chess_clock
    // Info popover for sudden death
    Component {
         id: infoSuddenDeath
         Dialog {
             id: dialogSuddenDeath
             title: i18n.tr("Sudden Death")
             text: i18n.tr("This is the simplest methodology. Each player is assigned a fixed amount of time for the whole game: once a player's main time expires, he loses the game.")
             Button {
                 text: i18n.tr("That was simple!")
                 onClicked: PopupUtils.close(dialogSuddenDeath)
             }
         }
    }
    // Info popover for hour glass
    Component {
         id: infoHourGlass
         Dialog {
             id: dialogHourGlass
             title: i18n.tr("Hour Glass")
             text: i18n.tr("A player loses in this time control when they allow the difference between both clocks to reach the specified total amount. For example, if the total is defined as one minute, both players start their clocks at thirty seconds. Every second the first player uses to think in their moves is subtracted from their clock and added to their opponent's clock. If they use thirty seconds to move, the difference between the clocks reaches one minute, and the time flag falls to indicate that they lose by time. If they have used twenty nine seconds and then push the clock's button, they have one second left on their clock and their opponent has fifty-nine seconds.")
             Button {
                 text: i18n.tr("Ok, got it!")
                 onClicked: PopupUtils.close(dialogHourGlass)
             }
         }
    }
    // Info popover for Fischer
    Component {
         id: infoFischer
         Dialog {
             id: dialogFischer
             title: i18n.tr("Fischer")
             text: i18n.tr("Before a player has made their move, a specified time increment is added to their clock. Time can be accumulated, so if the player moves within the delay period, their remaining time actually increases. For example, if the delay time is five seconds, and a player has four seconds left on their clock, as soon as their opponent moves, they receive the increment and has nine seconds to make a move. If they take two seconds to move, on the start of their next move they have twelve seconds.")
             Button {
                 text: i18n.tr("I understand!")
                 onClicked: PopupUtils.close(dialogFischer)
             }
         }
    }
    // Info popover for count up
    Component {
         id: infoCountUp
         Dialog {
             id: dialogCountUp
             title: i18n.tr("Count Up")
             text: i18n.tr("In this time control the total time used by each of the players is recorded.")
             Button {
                 text: i18n.tr("Is that all?")
                 onClicked: PopupUtils.close(dialogCountUp)
             }
         }
    }
    // Info popover for Bronstein
    Component {
         id: infoBronstein
         Dialog {
             id: dialogBronstein
             title: i18n.tr("Bronstein")
             text: i18n.tr("With the Bronstein timing method, the increment is always added after the move. But unlike Fischer, not always the maximum increment is added. If a player expends more than the specified increment, then the entire increment is added to the player's clock. But if a player has moved faster than the time increment, only the exact amount of time expended by the player is added. For example, if the delay is five seconds, the player has ten seconds left in their clock before their turn and during their turn they spend three seconds, after they press the clock button to indicate the end of their turn, their clock increases by only three seconds (not five). This ensures that the time left on the clock can never increase, even if a player makes fast moves.")
             Button {
                 text: i18n.tr("Acknowledged.")
                 onClicked: PopupUtils.close(dialogBronstein)
             }
         }
    }

}
