import Quickshell
import Quickshell.Services.Pipewire

BarModule {
  readonly property var sink: Pipewire.defaultAudioSink
  readonly property var audio: sink?.audio ?? null
  readonly property int volume: Math.round((audio?.volume ?? 0) * 100)
  readonly property bool muted: audio?.muted ?? false
  readonly property bool bluetooth: (sink?.name ?? "").startsWith("bluez_")

  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink]
  }

  text: bluetooth ? `${sink.description} ${volume}%` : `VOL ${volume}%`
  color: muted ? Theme.critical : Theme.fg

  onClicked: button => {
    if (button === Qt.RightButton) {
      if (audio) audio.muted = !audio.muted;
    } else if (button === Qt.LeftButton) {
      Quickshell.execDetached(["pavucontrol"]);
    }
  }

  onScrolled: delta => {
    if (!audio) return;
    const step = delta > 0 ? 0.05 : -0.05;
    audio.volume = Math.max(0, Math.min(1, audio.volume + step));
  }
}
