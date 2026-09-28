pragma Singleton
import Quickshell.Services.Notifications
import QtQuick
import Quickshell

Item {
  property alias trackedNotifications: notifServer.trackedNotifications
  property bool doNotDisturb: false
  property var activeToasts: []

  NotificationServer {
    id: notifServer
    onNotification: (notification) => {
      notification.tracked = true

      if (!NotificationService.doNotDisturb) {
        const timeout = notification.expireTimeout > 0
        ? notification.expireTimeout * 1000
        : Constants.notificationDefaultTimeout

        NotificationService.activeToasts = [
          ...NotificationService.activeToasts,
          { notification: notification, expiresAt: Date.now() + timeout }
        ]
      }
    }
  }

  Timer {
    interval: 250
    running: true
    repeat: true
    onTriggered: {
      const now = Date.now()
      NotificationService.activeToasts = NotificationService.activeToasts.filter(t => t.notification && t.expiresAt > now)
    } 
  }
  function openAndDismiss(notification) {
    const entry = DesktopEntries.heuristicLookup(notification.appName)
    if (entry) entry.execute()
    notification.dismiss()
    activeToasts = activeToasts.filter(t => t.notification !== notification)
  }
}
