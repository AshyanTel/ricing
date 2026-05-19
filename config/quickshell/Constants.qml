pragma Singleton
import QtQuick

QtObject {
  readonly property string fontFamily: "JetBrains Mono Nerd Font"
  readonly property int fontSize: 12
  readonly property real textHorizontalOffset: 0.3 
  readonly property real textVerticalOffset: 0

  readonly property int dotSize: 18
  readonly property int dotSpacing: 3
  readonly property int animDuration: 200
  readonly property int minWorkspaces: 5

  readonly property int barHeight: 24
  readonly property int barExclusionHeight: barHeight + 8 
  readonly property int barRadius: barHeight / 2

  readonly property int hoverAnimDuration: 150

  readonly property int batteryCriticalThreshold: 15
  readonly property int batteryBlinkDuration: 500

  readonly property int pillPadding: 8

  readonly property int cpuHistoryLength: 20
  readonly property int cpuGraphWidth: 40
  
  readonly property int netPollInterval: 2000

  readonly property int diskCircleThickness: 3

  readonly property real backgroundOpacity: 0.95

  readonly property int menuHeight: 400
  readonly property int menuWidth: Math.round(menuHeight * 1.618)
  readonly property int menuBarGap: 8
  readonly property int menuAutoCloseDelay: 1000
  readonly property int menuPadding: 12
  readonly property int menuTabHeight: 32

  readonly property int notificationDefaultTimeout: 5000
  readonly property int toastWidth: 250
}
