import QtQuick

// Base text module: label, colour, tooltip, click and scroll handling.
Item {
  id: root

  property string text: ""
  property color color: Theme.fg
  property string tooltip: ""
  property real fontSize: Theme.fontSize
  readonly property bool hovered: area.containsMouse

  signal clicked(int button)
  signal scrolled(int delta)

  implicitWidth: Math.round(label.implicitWidth)
  implicitHeight: label.implicitHeight

  Text {
    id: label
    anchors.centerIn: parent
    anchors.verticalCenterOffset: -1
    text: root.text
    color: root.color
    font.family: Theme.fontFamily
    font.pointSize: root.fontSize
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

  }

  MouseArea {
    id: area
    anchors.fill: parent
    hoverEnabled: true
    acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
    onClicked: mouse => root.clicked(mouse.button)
    onWheel: wheel => root.scrolled(wheel.angleDelta.y)
  }

  HoverTip {
    target: root
    text: root.tooltip
    shown: root.hovered
  }
}
