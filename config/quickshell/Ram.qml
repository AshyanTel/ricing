import Quickshell.Io
import QtQuick

Item {
  id: ramContainer

  property real ramUsage: 0
  property var history: []

  width: row.width
  height: Constants.dotSize

  Process {
    id: ramProc
    command: ["sh", "-c", "grep -E 'MemTotal|MemAvailable' /proc/meminfo"]
    stdout: SplitParser {
      splitMarker: ""
      onRead: (data) => {
        const lines = data.trim().split("\n")
        if (lines.length < 2) return

        const total = parseInt(lines[0].match(/\d+/)[0])
        const available = parseInt(lines[1].match(/\d+/)[0])

        ramContainer.ramUsage = Math.round(100 * (1 - available / total))
        ramContainer.history.push(ramContainer.ramUsage)
        if (ramContainer.history.length > Constants.cpuHistoryLength) {
          ramContainer.history.shift()
        }
        graph.requestPaint()
      }
    }
  }

  Timer {
    interval: 2000
    running: true
    repeat: true
    onTriggered: ramProc.running = true
  }

  Component.onCompleted: ramProc.running = true

  Row {
    id: row
    anchors.verticalCenter: parent.verticalCenter
    spacing: 4

    AlignedText {
      anchors.verticalCenter: parent.verticalCenter
      text: " "
      color: Colors.pink
    }

    AlignedText {
      anchors.verticalCenter: parent.verticalCenter
      text: ramContainer.ramUsage + "%"
      color: Colors.pink
    }

    Canvas {
      id: graph
      anchors.verticalCenter: parent.verticalCenter
      width: Constants.cpuGraphWidth
      height: Constants.dotSize

      onPaint: {
        const ctx = getContext("2d")
        ctx.clearRect(0, 0, width, height)

        if (ramContainer.history.length < 2) return

        ctx.strokeStyle = Colors.pink
        ctx.lineWidth = 1
        ctx.beginPath()

        const step = width / (Constants.cpuHistoryLength - 1)
        ramContainer.history.forEach((value, index) => {
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
