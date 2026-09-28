import Quickshell
import Quickshell.Wayland
import QtQuick

ShellRoot {
   PanelWindow {
    id: barLeft
    anchors { top: true; left: true }
    implicitWidth: leftRow.implicitWidth + Constants.pillPadding * 2 
    implicitHeight: Constants.barHeight
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    
    Rectangle {
      anchors.fill: parent

      color: Colors.withAlpha(Colors.base,Constants.backgroundOpacity)
      bottomRightRadius: Constants.barRadius
      Row {
        id: leftRow
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: Constants.pillPadding
        spacing: 12
        
        Cpu {}
        
        Ram {}

        Disk {}
      }
    }
  }

  PanelWindow {
    id: barCenter
    anchors { top: true; left: true; right: true }
    implicitHeight: Constants.barHeight
    exclusiveZone: Constants.barExclusionHeight
    color: "transparent"

    mask: Region { item: centerPill }

    Rectangle {
      id: centerPill
      anchors.centerIn: parent
      implicitWidth: centerRow.implicitWidth + Constants.pillPadding * 2
      height: parent.height
      color: Colors.withAlpha(Colors.base,Constants.backgroundOpacity)
      bottomLeftRadius: Constants.barRadius
      bottomRightRadius: Constants.barRadius  

      Row {
        id: centerRow
        anchors.centerIn: parent
        spacing: 12

        Battery {}
        
        Volume {}

        Workspaces {}
        
        Clock {}

        Notification {}
      }
    }

    MainMenu {
      id: mainMenu
      barWindow: barCenter
    }


    TapHandler {
      onTapped: mainMenu.requestedVisible ? mainMenu.dismiss() : mainMenu.reveal()
    }
  }

  Toasts {
    barWindow: barCenter
  }

  PanelWindow {
    id: barRight
    anchors { top: true; right: true }
    implicitWidth: rightRow.implicitWidth + Constants.pillPadding * 2
    implicitHeight: Constants.barHeight
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    
    Rectangle {
      anchors.fill: parent
      color: Colors.withAlpha(Colors.base,Constants.backgroundOpacity)
      bottomLeftRadius: Constants.barRadius
      
      Row {
        id: rightRow
        anchors.centerIn: parent
        spacing: 12

        Wifi {}

        Bluetooth {}

      }
    }
  }
}
