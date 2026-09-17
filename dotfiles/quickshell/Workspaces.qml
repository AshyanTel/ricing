import Quickshell.Hyprland
import QtQuick

Item {
    id: wsContainer

    width: wsRow.width
    height: wsRow.height

    property var wsList: {
      const existing = Hyprland.workspaces.values.filter(ws => ws.id > 0)
      const maxId = Math.max(Constants.minWorkspaces, ...existing.map(ws => ws.id))
      const result = []
      for (let id = 1; id <= maxId; id++) {
        const found = existing.find(ws => ws.id === id)
        result.push({ id: id, active: found ? found.active : false })
      }
      return result
    }
    property int activeIndex: (wsList || []).findIndex(ws => ws.active)

    Rectangle {
        id: halo
        width: Constants.dotSize
        height: Constants.dotSize
        radius: width / 2
        color: Colors.green
        x: wsContainer.activeIndex * (Constants.dotSize + Constants.dotSpacing)

        Behavior on x {
            NumberAnimation { duration: Constants.animDuration; easing.type: Easing.OutCubic }
        }
    }

    Row {
        id: wsRow
        spacing: Constants.dotSpacing

        Repeater {
            model: wsContainer.wsList
            Rectangle {
                required property var modelData
                required property int index
                width: Constants.dotSize
                height: Constants.dotSize
                radius: width / 2
                color: (hoverHandler.hovered && !modelData.active) ? Colors.crust : "transparent"

                Behavior on color {
                    ColorAnimation { duration: Constants.hoverAnimDuration }
                }

                property real pointX: index * (Constants.dotSize + Constants.dotSpacing)
                property real clipX: Math.max(0, halo.x - pointX)
                property real clipWidth: Math.max(0, Math.min(Constants.dotSize, halo.x + Constants.dotSize - pointX) - clipX)

                HoverHandler {
                    id: hoverHandler
                    cursorShape: Qt.PointingHandCursor
                }

                TapHandler {
                    onTapped: Hyprland.dispatch('hl.dsp.focus({ workspace = ' + modelData.id + ' })')
                }

                AlignedText {
                    anchors.centerIn: parent
                    text: modelData.id
                    color: Colors.overlay0
                }

                Item {
                    x: parent.clipX
                    width: parent.clipWidth
                    height: Constants.dotSize
                    clip: true

                    Item {
                        width: Constants.dotSize
                        height: Constants.dotSize
                        x: -parent.parent.clipX

                        AlignedText {
                            anchors.centerIn: parent
                            text: modelData.id
                            color: Colors.crust
                        }
                    }
                }
            }
        }
    }
}
