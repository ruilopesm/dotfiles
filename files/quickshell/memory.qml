import QtQuick
import Quickshell.Io

BarModule {
  id: root

  property real totalGb: 0
  property real usedGb: 0

  text: `RAM ${usedGb.toFixed(2)}G`
  tooltip: `Used: ${usedGb.toFixed(2)}G\nTotal: ${totalGb.toFixed(2)}G`

  FileView {
    id: meminfo
    path: "/proc/meminfo"

    onLoaded: {
      const kb = key => Number(new RegExp(`^${key}:\\s+(\\d+)`, "m").exec(text())?.[1] ?? 0);
      const total = kb("MemTotal");
      root.totalGb = total / 1048576;
      root.usedGb = (total - kb("MemAvailable")) / 1048576;
    }
  }

  Timer {
    interval: 10000
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: meminfo.reload()
  }
}
