import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

Item {
  id: root

  required property var screen
  readonly property var monitor: Hyprland.monitorFor(screen)

  implicitWidth: row.implicitWidth

  function focus(expr) {
    Quickshell.execDetached(["hyprctl", "dispatch", `hl.dsp.focus({ workspace = ${expr} })`]);
  }

  RowLayout {
    id: row
    anchors.fill: parent
    spacing: 2.7

    Repeater {
      // Numbered workspaces of this monitor only, sorted by id
      model: Hyprland.workspaces.values
        .filter(w => w.id > 0 && w.monitor === root.monitor)
        .sort((a, b) => a.id - b.id)

      Rectangle {
        id: button
        required property var modelData
        readonly property bool focused: modelData.focused
        readonly property bool visibleOnMonitor: modelData.active

        implicitWidth: Math.max(29.6, label.implicitWidth + 15.6)
        Layout.fillHeight: true
        radius: 2
        color: focused ? Theme.surface : (mouse.containsMouse ? Theme.surfaceHover : "transparent")

        Text {
          id: label
          anchors.centerIn: parent
          anchors.verticalCenterOffset: -5.5
          text: button.modelData.name
          font.family: Theme.fontFamily
          font.pointSize: Theme.fontSize
          font.weight: Theme.fontWeight
          renderType: Text.QtRendering
          font.hintingPreference: Font.PreferNoHinting
          font.letterSpacing: -0.4

          // Qt renders thinner than GTK at the same weight; a faint second copy
          // on top darkens the antialiased edges to match Waybar's weight.
          Text {
            opacity: 0.4
            text: parent.text
            color: parent.color
            font: parent.font
            renderType: parent.renderType
          }

          color: Theme.fg
        }

        MouseArea {
          id: mouse
          anchors.fill: parent
          hoverEnabled: true
          onClicked: root.focus(button.modelData.id)
        }
      }
    }
  }

  // Scroll over the workspaces to switch (relative to existing ones, like "e+1")
  MouseArea {
    anchors.fill: parent
    acceptedButtons: Qt.NoButton
    onWheel: wheel => root.focus(wheel.angleDelta.y > 0 ? '"e+1"' : '"e-1"')
  }
}
