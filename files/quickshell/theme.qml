pragma Singleton

import QtQuick
import Quickshell

Singleton {
  // Qt resolves plain "Fira Code" to the Regular file even with bold set; this family name picks the real Bold file
  readonly property string fontFamily: "Fira Code SemiBold"
  readonly property real fontSize: 8.95
  readonly property int fontWeight: Font.Black

  readonly property color bg: "#000000"
  readonly property color surface: "#222222"
  readonly property color surfaceHover: "#111111"
  readonly property color fg: "#CCCCCC"
  readonly property color fgBright: "#EEEEEE"
  readonly property color fgSoft: "#DDDDDD"
  readonly property color fgHover: "#AAAAAA"
  readonly property color fgDim: "#888888"
  readonly property color accent: "#7EB7E2"
  readonly property color warning: "#FFD54F"
  readonly property color critical: "#FF1744"

  readonly property int barHeight: 28
  readonly property int radius: 3
  readonly property real moduleSpacing: 11
}
