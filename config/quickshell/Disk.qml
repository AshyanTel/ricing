import Quickshell.Io
import QtQuick

Item {
  id: diskContainer

  property var disks: []

  width: row.width
  height: Constants.dotSize

  Process {
    id: dfProc
    command: ["sh", "-c", "df -B1 --output=source,target,pcent,size | grep -E '^/dev'"]
    stdout: SplitParser {
      splitMarker: ""
      onRead: (data) => {
        const lines = data.trim().split("\n")
        const grouped = {}
        for (const line of lines) {
          const parts = line.trim().split(/\s+/)
          const device = parts[0]
          const mount = parts[1]
          const percent = parseInt(parts[2])
          const size = parts[3]

          if (!grouped[device]) {
            grouped[device] = { device, mounts: [], percent, size }
          }
          grouped[device].mounts.push(mount)
        }
        diskContainer.disks = Object.values(grouped)
      }
    }
  }

  Timer {
    interval: 5000
    running: true
    repeat: true
    onTriggered: dfProc.running = true
  }

  Component.onCompleted: dfProc.running = true

  Row {
    id: row
    anchors.verticalCenter: parent.verticalCenter
    spacing: 10

    Repeater {
      model: diskContainer.disks
      Row {
        required property var modelData
        spacing: 4

        Canvas {
          id: diskCircle
          anchors.verticalCenter: parent.verticalCenter
          width: Constants.dotSize
          height: Constants.dotSize

          property var data: parent.modelData

          onDataChanged: requestPaint()

          onPaint: {
            const ctx = getContext("2d")
            ctx.clearRect(0, 0, width, height)

            const centerX = width / 2
            const centerY = height / 2
            const radius = width / 2 - Constants.diskCircleThickness / 2

            ctx.lineWidth = Constants.diskCircleThickness
            ctx.strokeStyle = Colors.surface1
            ctx.beginPath()
            ctx.arc(centerX, centerY, radius, 0, Math.PI * 2)
            ctx.stroke()

            ctx.strokeStyle = Colors.red
            ctx.beginPath()
            const endAngle = -Math.PI / 2 + (data.percent / 100) * Math.PI * 2
            ctx.arc(centerX, centerY, radius, -Math.PI / 2, endAngle)
            ctx.stroke()
          }
        }

        AlignedText {
          anchors.verticalCenter: parent.verticalCenter
          text: modelData.mounts.join(", ") + " " + modelData.percent + "%"
          color: Colors.red
        }
      }
    }
  }
}
