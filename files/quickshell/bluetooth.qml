import Quickshell
import Quickshell.Bluetooth

BarModule {
  readonly property var connected: (Bluetooth.devices?.values ?? []).filter(d => d.connected)

  // Waybar shows nothing while no device is connected
  visible: connected.length > 0
  text: "BT"
  tooltip: connected.map(d => d.batteryAvailable
    ? `${d.name}: ${Math.round(d.battery * 100)}%` : d.name).join("\n")

  onClicked: Quickshell.execDetached(["blueman-manager"])
}
