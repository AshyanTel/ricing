import Quickshell
import QtQuick

PopupWindow {
  id: root
  color: "transparent"

  default property alias content: contentItem.data
  property int slideDistance: 12
  property int animDuration: 320

  property bool requestedVisible: false

  function reveal() {
    requestedVisible = true
    visible = true
  }

  function dismiss() {
    requestedVisible = false
    closeTimer.start()
  }

  Timer {
    id: closeTimer
    interval: root.animDuration
    onTriggered: root.visible = false
  }

  Item {
    id: contentItem
    anchors.fill: parent
    opacity: root.requestedVisible ? 1 : 0
    y: root.requestedVisible ? 0 : root.slideDistance

    Behavior on opacity {
      NumberAnimation { duration: root.animDuration; easing.type: Easing.OutCubic }
    }
    Behavior on y {
      NumberAnimation { duration: root.animDuration; easing.type: Easing.OutCubic }
    }
  }
}
