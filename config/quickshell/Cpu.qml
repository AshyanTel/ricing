import Quickshell.Io
import QtQuick

Item {
  id: cpuContainer

  property real cpuUsage: 0
  property int lastTotal: 0
  property int lastIdle: 0
  property real cpuTemp: 0
  property var history: []

  width: row.width
  height: Constants.dotSize

  Process {
    id: cpuProc
    command: ["sh", "-c", "head -1 /proc/stat"]
    stdout: SplitParser {
      onRead: (data) => {
        if (!data) return
        const p = data.trim().split(/\s+/)
        const idle = parseInt(p[4]) + parseInt(p[5])
        const total = p.slice(1, 8).reduce((a, b) => a + parseInt(b), 0)

        if (cpuContainer.lastTotal > 0) {
          cpuContainer.cpuUsage = Math.round(100 * (1 - (idle - cpuContainer.lastIdle) / (total - cpuContainer.lastTotal)))
          cpuContainer.history.push(cpuContainer.cpuUsage)
          if (cpuContainer.history.length > Constants.cpuHistoryLength) {
            cpuContainer.history.shift()
          }
          graph.requestPaint()
        }

        cpuContainer.lastTotal = total
        cpuContainer.lastIdle = idle
      }
    }
  }

  Process {
    id: tempProc
    command: ["cat", "/sys/class/thermal/thermal_zone*/temp"]
    stdout: SplitParser {
      onRead: (data) => {
        if (!data) return
        cpuContainer.cpuTemp = Math.round(parseInt(data.trim()) / 1000)
      }
    }
  }

  Timer {
    interval: 2000
    running: true
    repeat: true
    onTriggered: {
      cpuProc.running = true
      tempProc.running = true
    }
  }

  Component.onCompleted: {
    cpuProc.running = true
    tempProc.running = true
  }

  Row {
    id: row
    anchors.verticalCenter: parent.verticalCenter
    spacing: 4

    AlignedText {
      id: cpuIcon
      anchors.verticalCenter: parent.verticalCenter
      text: ""
      color: Colors.mauve
    }

    AlignedText {
      anchors.verticalCenter: parent.verticalCenter
      text: cpuContainer.cpuUsage + "% "
      color: Colors.mauve
    }

    AlignedText {
      anchors.verticalCenter: parent.verticalCenter
      text: cpuContainer.cpuTemp + "°C"
      color: Colors.mauve
    }

    Canvas {
      id: graph
      anchors.verticalCenter: parent.verticalCenter
      width: Constants.cpuGraphWidth
      height: Constants.dotSize

      onPaint: {
        const ctx = getContext("2d")
        ctx.clearRect(0, 0, width, height)

        if (cpuContainer.history.length < 2) return

        ctx.strokeStyle = Colors.mauve
        ctx.lineWidth = 1
        ctx.beginPath()

        const step = width / (Constants.cpuHistoryLength - 1)
        cpuContainer.history.forEach((value, index) => {
          const x = index * step
          const y = height - (value / 100) * height
          if (index === 0) ctx.moveTo(x, y)
          else ctx.lineTo(x, y)
        })

        ctx.stroke()
      }
    }
  }
}
