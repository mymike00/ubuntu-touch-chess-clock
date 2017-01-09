TEMPLATE = aux
TARGET = chessclock

RESOURCES += chessclock.qrc

QML_FILES += $$files(*.qml,true) \
             $$files(*.js,true)

CONF_FILES +=  chessclock.apparmor \
               resources/chessclock.svg \
               resources/chessclock.png \
               resources/reset.png \
               resources/alarm1.wav \
               resources/chessclock_transparrent.png \
               resources/click.wav

AP_TEST_FILES += tests/autopilot/run \
                 $$files(tests/*.py,true)               

OTHER_FILES += $${CONF_FILES} \
               $${QML_FILES} \
               $${AP_TEST_FILES} \
               chessclock.desktop

SUBDIRS += components

#specify where the qml/js files are installed to
qml_files.path = /chessclock
qml_files.files += $${QML_FILES}

#specify where the config files are installed to
config_files.path = /chessclock
config_files.files += $${CONF_FILES}

#install the desktop file, a translated version is 
#automatically created in the build directory
desktop_file.path = /chessclock
desktop_file.files = $$OUT_PWD/chessclock.desktop
desktop_file.CONFIG += no_check_exist

INSTALLS+=config_files qml_files desktop_file

DISTFILES += \
    components/Clock.qml \
    components/InfoPage.qml \
    components/SettingsPage.qml \
    components/AboutPage.qml \
    components/ClockHeader.qml
