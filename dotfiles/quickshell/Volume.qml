import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

Item {
  id: volumeContainer

  property var sink: Pipewire.defaultAudioSink
  property real volume: sink?.audio?.volume ?? 0
  property bool muted: sink?.audio?.muted ?? false

  readonly property var volumeIcons: ["󰕿", "󰖀", "󰕾"]

  function currentIcon() {
    if (muted) return "󰝟"
    const index = Math.min(volumeIcons.length - 1, Math.floor(volume * volumeIcons.length))
    return volumeIcons[index]
  }

  PwObjectTracker {
    objects: [sink]
  }

  width: row.width
  height: Constants.dotSize

  Row {
    id: row
    anchors.verticalCenter: parent.verticalCenter
    spacing: 4

    AlignedText {
      anchors.verticalCenter: parent.verticalCenter
      text: volumeContainer.currentIcon()
      color: Colors.yellow
    }

    AlignedText {
      anchors.verticalCenter: parent.verticalCenter
      text: (volumeContainer.muted ? 0 : Math.round(volumeContainer.volume * 100)) + "%"
      color: Colors.yellow
    }
  }

  TapHandler {
    onTapped: {
      if (volumeContainer.sink?.audio) {
        volumeContainer.sink.audio.muted = !volumeContainer.sink.audio.muted
      }
    }
  }

  HoverHandler {
    id: hoverHandler
    cursorShape: Qt.PointingHandCursor
  }

  WheelHandler {
    onWheel: (event) => {
      if (volumeContainer.sink?.audio) {
        const step = Constants.volumeStep
        const delta = event.angleDelta.y > 0 ? step : -step
        const newVolume = Math.max(0, Math.min(1, volumeContainer.sink.audio.volume + delta))
        volumeContainer.sink.audio.volume = newVolume
      }
    }
  }
}
