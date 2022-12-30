import QtQuick 2.9
import QtQuick.Layouts 1.3
import org.asteroid.controls 1.0
import org.asteroid.utils 1.0
import org.asteroid.settings 1.0
import org.nemomobile.systemsettings 1.0
import Nemo.Configuration 1.0
import Qt.labs.settings 1.1

Item {
    TapToWake { id: tapToWake }
    TiltToWake { id: tiltToWake }
    DisplaySettings { id: displaySettings }
    ConfigurationValue {
        id: useBip
        key: "/org/asteroidos/settings/use-burn-in-protection"
        defaultValue: DeviceInfo.needsBurnInProtection
    }

    PageHeader {
        id: title
        text: qsTrId("id-display-page")
    }

    Flickable {
        anchors.fill: parent
        contentHeight: Dims.h(30) + 4*Dims.h(34) + (DeviceInfo.needsBurnInProtection ? Dims.h(34) : 0)
        boundsBehavior: Flickable.DragOverBounds
        flickableDirection: Flickable.VerticalFlick

        GridLayout {
            id: onOffSettings
            columns: 2
            anchors.fill: parent
            anchors.margins: Dims.l(15)

            Item {
                id: brightnessSetting
                height: Dims.h(30)
                Layout.fillWidth: true
                Layout.columnSpan: 2
                Label {
                    //% "Brightness"
                    text: qsTrId("id-brightness")
                    font.pixelSize: Dims.l(6)
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.Wrap
                }

                IconButton {
                    iconName: "ios-remove-circle-outline"
                    edge: undefinedEdge
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: Dims.h(10)
                    onClicked: {
                        var newVal = displaySettings.brightness - 10
                        if(newVal < 0) newVal = 0
                        displaySettings.brightness = newVal
                    }
                }

                Label {
                    text: displaySettings.brightness + "%"
                    font.pixelSize: Dims.l(6)
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.Wrap
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: Dims.h(10)
                    height: Dims.h(20)
                }

                IconButton {
                    width: Dims.w(20)
                    height: width
                    iconName: "ios-add-circle-outline"
                    edge: undefinedEdge
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: Dims.h(10)
                    onClicked: {
                        var newVal = displaySettings.brightness + 10
                        if(newVal > 100) newVal = 100
                        displaySettings.brightness = newVal
                    }
                }
            }

            Label {
                //% "Automatic brightness"
                text: qsTrId("id-automatic-brightness")
                font.pixelSize: Dims.l(6)
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.Wrap
                Layout.maximumWidth: Dims.w(50)
            }

            Switch {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                width: Dims.l(20)
                checked: displaySettings.ambientLightSensorEnabled
                onCheckedChanged: displaySettings.ambientLightSensorEnabled = checked
            }

            Label {
                //% "Always on Display"
                text: qsTrId("id-always-on-display")
                font.pixelSize: Dims.l(6)
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.Wrap
                Layout.maximumWidth: Dims.w(50)
            }

            Switch {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                width: Dims.l(20)
                checked: displaySettings.lowPowerModeEnabled
                onCheckedChanged: displaySettings.lowPowerModeEnabled = checked
            }

            Label {
                //% "Burn in protection"
                text: qsTrId("id-burn-in-protection")
                font.pixelSize: Dims.l(6)
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.Wrap
                Layout.maximumWidth: Dims.w(50)
                visible: DeviceInfo.needsBurnInProtection
            }

            Switch {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                width: Dims.l(20)
                checked: useBip.value
                onCheckedChanged: useBip.value = checked
                visible: DeviceInfo.needsBurnInProtection
            }

            Label {
                //% "Tilt-to-wake"
                text: qsTrId("id-tilt-to-wake")
                font.pixelSize: Dims.l(6)
                opacity: !tiltToWake.available ? 0.6 : 1.0
                font.strikeout: !tiltToWake.available
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.Wrap
                Layout.maximumWidth: Dims.w(50)
            }

            Switch {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                width: Dims.l(20)
                enabled: tiltToWake.available
                checked: tiltToWake.enabled
                onCheckedChanged: tiltToWake.enabled = checked
            }

            Label {
                //% "Tap-to-wake"
                text: qsTrId("id-tap-to-wake")
                font.pixelSize: Dims.l(6)
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.Wrap
                Layout.maximumWidth: Dims.w(50)
            }

            Switch {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                width: Dims.l(20)
                checked: tapToWake.enabled
                onCheckedChanged: tapToWake.enabled = checked
            }
        }
    }
}

