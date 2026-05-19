import Quickshell
import Quickshell.Wayland
import QtQuick

PanelWindow {
    id: toastWindow
    required property var barWindow

    anchors { top: true }
    implicitWidth: Constants.toastWidth
    implicitHeight: 400
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    
    mask: Region { item: toastColumn }
    Column {
      id: toastColumn
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: Constants.barHeight + Constants.menuBarGap
        spacing: 8
        width: Constants.toastWidth

        Repeater {
            model: NotificationService.activeToasts

            Rectangle {
                TapHandler {
                  onTapped: NotificationService.openAndDismiss(modelData.notification)
                }

                required property var modelData
                width: parent.width
                height: toastColumn.height + 16
                radius: 10
                color: Colors.withAlpha(Colors.base, Constants.backgroundOpacity)
                border.color: Colors.crust
                border.width: 2

                Column {
                    id: toastColumn
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.margins: 8
                    anchors.top: parent.top
                    anchors.topMargin: 8
                    spacing: 2

                    AlignedText {
                      text: (modelData.notification?.appName ?? "") + " : " + (modelData.notification?.summary ?? "")
                      color: Colors.mauve
                    }

                    AlignedText {
                      text: modelData.notification?.body ?? ""
                      color: Colors.text
                      width: parent.width
                      wrapMode: Text.WordWrap
                    }
                }
            }
        }
    }
}
