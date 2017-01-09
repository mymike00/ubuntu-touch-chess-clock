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

Layouts {
    visible: true
    anchors.horizontalCenter: parent.horizontalCenter
    y: 3*parent.height/5
    width: parent.height/5
    height: parent.height/5
    id: _icon
    UbuntuShape {
        Layouts.item: "icon"
        backgroundColor: (mainView.paused) ? "gray" : "\darkgray"
        anchors.fill: parent
        source: Image {
            objectName: "aboutImage"
            source: "chessclock_transparrent.png"
            smooth: true
            fillMode: Image.PreserveAspectFit

        }
        MouseArea {
            anchors.fill: parent
            onPressAndHold: mainView.reset()
            onPressed: mainView.paused = !mainView.paused
        }
    }
}


