//@ pragma Env QSG_DISTANCEFIELD_ANTIALIASING=gray

import Quickshell

ShellRoot {
  Variants {
    model: Quickshell.screens

    Bar {
      required property var modelData
      screen: modelData
    }
  }
}
