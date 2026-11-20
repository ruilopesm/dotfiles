import QtQuick
import Quickshell.Services.UPower

BarModule {
  id: root

  readonly property var device: UPower.displayDevice
  // UPower percentage is 0-1 in current Quickshell; accept 0-100 too
  readonly property int percent: Math.round(device.percentage <= 1 ? device.percentage * 100 : device.percentage)
  readonly property bool charging: device.state === UPowerDeviceState.Charging
    || device.state === UPowerDeviceState.FullyCharged
    || device.state === UPowerDeviceState.PendingCharge
  readonly property bool critical: percent <= 15 && !charging
  readonly property bool warning: percent <= 30 && !charging

  function duration(seconds) {
    const h = Math.floor(seconds / 3600);
    const m = Math.floor((seconds % 3600) / 60);
    return `${h}h ${m}m`;
  }

  visible: device.ready && device.isPresent
  text: `BAT ${percent}%`
  color: critical ? Theme.critical : (warning ? Theme.warning : Theme.fgDim)
  tooltip: {
    if (device.state === UPowerDeviceState.Charging && device.timeToFull > 0)
      return `Charging: ${duration(device.timeToFull)} to full`;
    if (device.state === UPowerDeviceState.Discharging && device.timeToEmpty > 0)
      return `Discharging: ${duration(device.timeToEmpty)} left`;
    return device.state === UPowerDeviceState.FullyCharged ? "Full" : "";
  }

  SequentialAnimation on opacity {
    running: root.critical
    loops: Animation.Infinite
    onRunningChanged: if (!running) root.opacity = 1

    NumberAnimation { to: 0.25; duration: 500 }
    NumberAnimation { to: 1; duration: 500 }
  }
}
