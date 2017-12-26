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
import QtQuick.Window 2.2
import Ubuntu.Layouts 0.1
import Ubuntu.Components.ListItems 1.3 as ListItem
import QtGraphicalEffects 1.0

Page {
    id: aboutPage
    header: PageHeader {
        id: aboutPageHeader
        title: i18n.tr("About")
        flickable: aboutTheApp
    }

    Flickable {
        id: aboutTheApp
        contentHeight: _settingsColumn.height
        anchors.fill: parent

        Column {
            id: _settingsColumn

            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }

            Layouts {
                id: _icon
                height: aboutPage.height/2
                width: aboutPage.height/2
                ProportionalShape {
                   id: logoShape
                    Layouts.item: "icon"
                    anchors.fill: parent
                    anchors.topMargin: units.gu(2)
                    anchors.bottomMargin: units.gu(2)
                    anchors.leftMargin: units.gu(2)
                    anchors.rightMargin: units.gu(2)
                    aspect: UbuntuShape.Flat
                    source: Image {
                        objectName: "aboutImage"
                        source: "chessclock.png"
                        smooth: true
                        fillMode: Image.PreserveAspectFit
                    }
                }
            }
            ListItem.Divider { }
            ListItem.Subtitled {
                text: i18n.tr("Actual Mainainer")
                subText: "Michele Castellazzi"
            }
            ListItem.Subtitled {
                text: i18n.tr("Original Author")
                subText: "Jonas Tjemsland"
            }
            ListItem.Subtitled {
                text: i18n.tr("Website")
                subText: "https://github.com/mymike00/ubuntu-touch-chess-clock"
            }
            ListItem.Subtitled {
                text: i18n.tr("Report an issue")
                subText: "https://github.com/mymike00/ubuntu-touch-chess-clock/issue"
            }
            ListItem.Subtitled {
                text: i18n.tr("Version")
                subText: "1.5"
            }
            ListItem.Subtitled {
                text: i18n.tr("Date")
                subText: i18n.tr("January 9, 2017")
            }
        }
    }
}
