import QtQuick

Item {
    id: notificationContainer

    width: row.width
    height: Constants.dotSize

    Row {
        id: row
        anchors.verticalCenter: parent.verticalCenter
        spacing: 4

        AlignedText {
            anchors.verticalCenter: parent.verticalCenter
            text: NotificationService.doNotDisturb
                ? "󰂛"
                : (NotificationService.trackedNotifications.values.length > 0 ? "󱅫" : "󰂚")
            color: Colors.sky
        }

        AlignedText {
            anchors.verticalCenter: parent.verticalCenter
            text: NotificationService.trackedNotifications.values.length
            color: Colors.sky
            visible: !NotificationService.doNotDisturb && NotificationService.trackedNotifications.values.length > 0
        }
    }
}
