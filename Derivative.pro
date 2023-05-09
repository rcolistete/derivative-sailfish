# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = Derivative

CONFIG += sailfishapp_qml

OTHER_FILES += qml/Derivative.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/Derivative.spec \
    rpm/Derivative.yaml \
    translations/*.ts \
    Derivative.desktop \
    qml/pages/AboutPage.qml \
    qml/pages/HelpPage.qml \
    qml/pages/derivative.py \
    qml/pages/DejaVuSansMono.ttf \
    rpm/Derivative.changes \
    qml/pages/SettingsPage.qml

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/Derivative-de.ts

