import Quickshell.Networking
import QtQuick
import Quickshell.Io

Item {
  id: wifiContainer

  property var wifiDevice: {
    for (const device of Networking.devices.values) {
      if (device.type === DeviceType.Wifi) return device
    }
    return null
  }

  property var connectedNetwork: {
    if (!wifiDevice) return null
    for (const network of wifiDevice.networks.values) {
      if (network.connected) return network
    }
    return null
  }

  readonly property var signalIcons: ["󰤯", "󰤟", "󰤢", "󰤥", "󰤨"]

  function currentIcon() {
    if (!connectedNetwork) return "󰤮"
    const strength = connectedNetwork.signalStrength
    const index = Math.min(signalIcons.length - 1, Math.floor(strength * signalIcons.length))
    return signalIcons[index]
  }


  property real rxSpeed: 0
  property real txSpeed: 0
  property int lastRx: 0
  property int lastTx: 0

  Process {
    id: netProc
    command: wifiContainer.wifiDevice
    ? ["sh", "-c", "cat /sys/class/net/" + wifiContainer.wifiDevice.name + "/statistics/rx_bytes /sys/class/net/" + wifiContainer.wifiDevice.name + "/statistics/tx_bytes"]
    : ["true"]
    stdout: SplitParser {
      splitMarker: ""
      onRead: (data) => {
        const lines = data.trim().split("\n")
        if (lines.length < 2) return
        const rx = parseInt(lines[0])
        const tx = parseInt(lines[1])

        if (wifiContainer.lastRx > 0) {
          wifiContainer.rxSpeed = (rx - wifiContainer.lastRx) / Constants.netPollInterval * 1000
          wifiContainer.txSpeed = (tx - wifiContainer.lastTx) / Constants.netPollInterval * 1000
        }

        wifiContainer.lastRx = rx
        wifiContainer.lastTx = tx
      }
    }
  }

  Timer {
    interval: Constants.netPollInterval
    running: true
    repeat: true
    onTriggered: netProc.running = true
  }

  Component.onCompleted: netProc.running = true   



  width: row.width
  height: Constants.dotSize

  function formatSpeed(bytesPerSec) {
    if (bytesPerSec < 1024) return Math.round(bytesPerSec) + " B/s "
    if (bytesPerSec < 1024 * 1024) return (bytesPerSec / 1024).toFixed(1) + " KB/s "
    return (bytesPerSec / (1024 * 1024)).toFixed(1) + " MB/s "
  }

  Row {
    id: row
    anchors.verticalCenter: parent.verticalCenter
    spacing: 4

    AlignedText {
      anchors.verticalCenter: parent.verticalCenter
      text: wifiContainer.currentIcon()
      color: Colors.sapphire
    }

    AlignedText {
      anchors.verticalCenter: parent.verticalCenter
      text: wifiContainer.connectedNetwork?.name + " " ?? "Disconnected "
      color: Colors.sapphire
    }

    AlignedText {
      anchors.verticalCenter: parent.verticalCenter
      text: " " + wifiContainer.formatSpeed(wifiContainer.rxSpeed)
      color: Colors.sapphire
    }

    AlignedText {
      anchors.verticalCenter: parent.verticalCenter
      text: " " + wifiContainer.formatSpeed(wifiContainer.txSpeed)
      color: Colors.sapphire
    }
  }
}
