import Quickshell.Services.UPower
import QtQuick

Item {
  id: batteryContainer

  property real percentage: UPower.displayDevice.percentage * 100
  property bool isCharging: UPower.displayDevice.state === UPowerDeviceState.Charging
  property bool isFull: UPower.displayDevice.state === UPowerDeviceState.FullyCharged
  property bool isCritical: percentage <= Constants.batteryCriticalThreshold && !isCharging
  property color displayColor: isCritical ? Colors.red : Colors.peach

  readonly property var chargingIcons: ["󰢟", "󰢜", "󰂆", "󰂇", "󰂈", "󰢝", "󰂉", "󰢞", "󰂊", "󰂋", "󰂅"]
  readonly property var defaultIcons: ["󰂎", "󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"]

  function currentIcon() {
    if (isFull) return "󱞜"
    const icons = isCharging ? chargingIcons : defaultIcons
    const index = Math.min(icons.length - 1, Math.floor(percentage / 10))
    return icons[index]
  }

  width: row.width
  height: Constants.dotSize

  SequentialAnimation {
    running: batteryContainer.isCritical
    loops: Animation.Infinite
    ColorAnimation { target: batteryContainer; property: "displayColor"; to: Colors.text; duration: Constants.batteryBlinkDuration }
    ColorAnimation { target: batteryContainer; property: "displayColor"; to: Colors.red; duration: Constants.batteryBlinkDuration }
  }

  Row {
    id: row
    anchors.verticalCenter: parent.verticalCenter
    spacing: 4

    AlignedText {
      anchors.verticalCenter: parent.verticalCenter
      text: batteryContainer.currentIcon()
      color: batteryContainer.displayColor
    }

    AlignedText {
      anchors.verticalCenter: parent.verticalCenter
      text: Math.round(batteryContainer.percentage) + "%"
      color: batteryContainer.displayColor
    }
  }
}
