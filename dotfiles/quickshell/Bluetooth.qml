import Quickshell
import Quickshell.Bluetooth
import QtQuick
import Quickshell.Widgets

Item {
  id: btContainer

  property var connectedDevices: Bluetooth.devices.values.filter(d => d.connected)

  width: row.width
  height: Constants.dotSize

  function deviceIcon(iconName, deviceName) {
    const name = deviceName.toLowerCase()
    if (iconName.includes("mouse")) return "󰍽"
    if (iconName.includes("keyboard")) return "󰌌"
    if (name.includes("buds") || name.includes("airpods")) return "󱡏"
    if (iconName.includes("headset") || iconName.includes("headphone")) return "󰋋"
    if (iconName.includes("phone")) return "󰄡"
    if (iconName.includes("watch")) return "󰢗"
    return "󰂯"
  }

  Row {
    id: row
    anchors.verticalCenter: parent.verticalCenter
    spacing: 4

    AlignedText {
      anchors.verticalCenter: parent.verticalCenter
      text: btContainer.connectedDevices.length > 0 ? "󰂱" : "󰂲"
      color: Colors.blue
    }

    AlignedText {
      anchors.verticalCenter: parent.verticalCenter
      text: btContainer.connectedDevices.length
      color: Colors.blue
      visible: btContainer.connectedDevices.length > 0
    }

    Repeater {
      model: btContainer.connectedDevices
      Row {
        required property var modelData
        spacing: 2

        AlignedText {
          anchors.verticalCenter: parent.verticalCenter
          text: btContainer.deviceIcon(modelData.icon, modelData.name)
          color: Colors.blue
        }

        AlignedText {
          anchors.verticalCenter: parent.verticalCenter
          text: modelData.batteryAvailable ? Math.round(modelData.battery * 100) + "%" : ""
          color: Colors.blue
        }
      }
    }
  }
}
