import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets

RowLayout {
  id: root

  required property var window

  spacing: 10

  Repeater {
    // Waybar does not show Blueman (its icon name is missing from the GTK theme), so hide it too
    model: SystemTray.items.values.filter(i => i.status !== Status.Passive && i.id !== "blueman")

    Item {
      id: entry
      required property var modelData

      implicitWidth: 14
      implicitHeight: 14

      IconImage {
        anchors.fill: parent
        implicitSize: 14
        mipmap: true
        // Like Waybar, prefer the app-supplied IconThemePath (Quickshell exposes it as ?path=)
        // over the icon theme, so e.g. Steam shows its own tray icon.
        readonly property var parts: entry.modelData.icon.split("?path=")
        readonly property string iconName: parts[0].replace("image://icon/", "")
        source: parts.length > 1 ? `file://${parts[1]}/${iconName}.png` : entry.modelData.icon
      }

      QsMenuAnchor {
        id: menu
        menu: entry.modelData.menu
        anchor.item: entry
        anchor.rect.y: entry.height + 4
      }

      MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
        onClicked: mouse => {
          if (mouse.button === Qt.MiddleButton) {
            entry.modelData.secondaryActivate();
          } else if (mouse.button === Qt.RightButton || entry.modelData.onlyMenu) {
            if (entry.modelData.hasMenu) menu.open();
          } else {
            entry.modelData.activate();
          }
        }
      }
    }
  }
}
