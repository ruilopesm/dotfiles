import QtQuick
import QtQuick.Layouts
import Quickshell

PanelWindow {
  id: root

  anchors {
    top: true
    left: true
    right: true
  }
  implicitHeight: Theme.barHeight
  color: Theme.bg

  Item {
    anchors.fill: parent
    anchors.topMargin: 2.7

    RowLayout {
      anchors.left: parent.left
      anchors.leftMargin: 8.3
      anchors.top: parent.top
      anchors.bottom: parent.bottom
      spacing: 0

      Launcher { Layout.alignment: Qt.AlignVCenter; Layout.leftMargin: 1; Layout.topMargin: -3 }
      Workspaces { screen: root.screen; Layout.leftMargin: 13.4; Layout.fillHeight: true }
      Media { Layout.leftMargin: 17; Layout.fillHeight: true }
    }

    Clock {
      anchors.centerIn: parent
    }

    RowLayout {
      anchors.right: parent.right
      anchors.rightMargin: 11
      anchors.verticalCenter: parent.verticalCenter
      spacing: Theme.moduleSpacing

      Bluetooth {}
      Volume {}
      Cpu {}
      Memory {}
      Battery { id: battery }
      Tray { window: root; Layout.leftMargin: battery.visible ? 5 : 16 }
    }
  }
}
