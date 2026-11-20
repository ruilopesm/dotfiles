import QtQuick
import Quickshell
import Quickshell.Io

BarModule {
  id: root

  property int usage: 0
  property var prev: ({})
  property string perCore: ""

  text: `CPU ${usage}%`
  tooltip: perCore

  onClicked: Quickshell.execDetached(["foot", "btop"])

  FileView {
    id: stat
    path: "/proc/stat"

    onLoaded: {
      const next = {};
      const lines = [];
      let total = 0;
      for (const line of text().split("\n")) {
        if (!line.startsWith("cpu")) continue;
        const parts = line.trim().split(/\s+/);
        const name = parts[0];
        const f = parts.slice(1).map(Number);
        const idle = f[3] + f[4];
        const sum = f.reduce((a, b) => a + b, 0);
        next[name] = { idle, sum };

        const p = root.prev[name];
        if (!p || sum === p.sum) continue;
        const pct = Math.round(100 * (1 - (idle - p.idle) / (sum - p.sum)));
        if (name === "cpu") total = pct;
        else lines.push(`${name.toUpperCase()}: ${pct}%`);
      }
      if (root.prev.cpu) {
        root.usage = total;
        root.perCore = lines.join("\n");
      }
      root.prev = next;
    }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: stat.reload()
  }
}
