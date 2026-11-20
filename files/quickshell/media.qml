import QtQuick
import Quickshell.Services.Mpris

Rectangle {
  id: root

  readonly property var players: Mpris.players.values
  readonly property var player: players.find(p => p.isPlaying) ?? players[0] ?? null

  function clip(s, n) {
    return s.length > n ? s.slice(0, n - 1) + "…" : s;
  }

  visible: player !== null
  color: Theme.surface
  radius: 2
  implicitWidth: label.implicitWidth + 21.3
  implicitHeight: label.implicitHeight

  Text {
    id: label
    anchors.centerIn: parent
    anchors.verticalCenterOffset: -5.5
    color: Theme.fgBright
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

    text: {
      if (!root.player) return "";
      if (!root.player.isPlaying) return "\uf04c Paused";
      const artist = root.player.trackArtist;
      const title = root.clip(root.player.trackTitle ?? "", 40);
      return artist ? `${artist} - ${title}` : title;
    }
  }
}
