import Quickshell
import QtQuick

AnimatedPopup {
  id: root
  required property var barWindow
  property int activeTabIndex: 0

  readonly property var tabs: [
    {
      label: "Notifications",
      icon: NotificationService.doNotDisturb
      ? "󰂛"
      : (NotificationService.trackedNotifications.values.length > 0 ? "󱅫" : "󰂚")
    },
    { label: "Media", icon: "󰝚" },
    { label: "Connections", icon: "󰤨" },
    { label: "Performance", icon: "󰻠" }
  ]

  anchor.window: barWindow
  anchor.rect.x: barWindow.width / 2 - implicitWidth / 2
  anchor.rect.y: Constants.barHeight + Constants.menuBarGap
  implicitWidth: Constants.menuWidth
  implicitHeight: Constants.menuHeight

  content: Rectangle {
    id: menuRect
    anchors.fill: parent
    color: Colors.withAlpha(Colors.base, Constants.backgroundOpacity)
    radius: 10
    border.color: Colors.crust
    border.width: 2

    HoverHandler {
      id: hoverHandler
    }

    Column {
      anchors.fill: parent
      anchors.margins: Constants.menuPadding
      spacing: Constants.menuPadding

      Row {
        width: parent.width
        spacing: 4

        Repeater {
          model: root.tabs
          Rectangle {
            required property var modelData
            required property int index

            width: (parent.width - parent.spacing * (root.tabs.length - 1)) / root.tabs.length
            height: Constants.menuTabHeight
            radius: 8
            color: root.activeTabIndex === index ? Colors.surface0 : "transparent"

            Row {
              anchors.centerIn: parent
              spacing: 4

              AlignedText {
                anchors.verticalCenter: parent.verticalCenter
                text: modelData.icon
                color: root.activeTabIndex === index ? Colors.mauve : Colors.text
              }

              AlignedText {
                anchors.verticalCenter: parent.verticalCenter
                text: modelData.label
                color: root.activeTabIndex === index ? Colors.mauve : Colors.text
              }
            }

            TapHandler {
              onTapped: root.activeTabIndex = index
            }
          }
        }
      }

      Item {
        width: parent.width
        height: parent.height - Constants.menuTabHeight - parent.spacing
        visible: root.activeTabIndex === 0

        Column {
          anchors.fill: parent
          spacing: 8

          Row {
            spacing: 4

            AlignedText {
              anchors.verticalCenter: parent.verticalCenter
              text: "Do Not Disturb"
              color: Colors.text
            }

            Rectangle {
              anchors.verticalCenter: parent.verticalCenter
              width: 32
              height: 18
              radius: 9
              color: NotificationService.doNotDisturb ? Colors.mauve : Colors.surface1

              Rectangle {
                width: 14
                height: 14
                radius: 7
                color: Colors.base
                y: 2
                x: NotificationService.doNotDisturb ? parent.width - width - 2 : 2

                Behavior on x {
                  NumberAnimation { duration: Constants.hoverAnimDuration }
                }
              }

              TapHandler {
                onTapped: NotificationService.doNotDisturb = !NotificationService.doNotDisturb
              }
            }
          }

          ListView {
            width: parent.width
            height: parent.height - 26
            clip: true
            spacing: 6
            model: NotificationService.trackedNotifications.values

            delegate: Rectangle {
              required property var modelData
              width: ListView.view.width
              height: notifColumn.height + 12
              radius: 8
              color: Colors.surface0

              Column {
                id: notifColumn
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 8
                anchors.top: parent.top
                anchors.topMargin: 6
                spacing: 2

                AlignedText {
                  text: modelData.appName + " — " + modelData.summary
                  color: Colors.mauve
                }

                AlignedText {
                  text: modelData.body
                  color: Colors.text
                  width: parent.width
                  wrapMode: Text.WordWrap
                }
              }

              TapHandler {
                onTapped: modelData.dismiss()
              }
            }
          }
        }
      }
    }
  }

  Timer {
    id: autoCloseTimer
    interval: Constants.menuAutoCloseDelay
    onTriggered: root.dismiss()
  }

  Connections {
    target: hoverHandler
    function onHoveredChanged() {
      if (hoverHandler.hovered) {
        autoCloseTimer.stop()
      } else {
        autoCloseTimer.start()
      }
    }
  }
}
