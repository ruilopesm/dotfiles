import QtQuick
import Quickshell

// Tooltip shown below `target` while `shown` is true and `text` is not empty.
PopupWindow {
  id: root

  required property Item target
  property string text: ""
  property bool shown: false

  visible: shown && text !== ""
  color: "transparent"
  implicitWidth: label.implicitWidth + 20
  implicitHeight: label.implicitHeight + 10

  anchor.item: target
  anchor.rect.x: (target.width - width) / 2
  anchor.rect.y: target.height + 4

  Rectangle {
    anchors.fill: parent
    color: Theme.surface
    radius: Theme.radius

    Text {
      id: label
      anchors.centerIn: parent
      text: root.text
      color: Theme.fg
      font.family: Theme.fontFamily
      font.pointSize: Theme.fontSize
      font.weight: Theme.fontWeight
      renderType: Text.QtRendering
      font.hintingPreference: Font.PreferNoHinting
      font.letterSpacing: -0.4

    }
  }
}
