import Quickshell

BarModule {
  text: "\uDB82\uDCC7"
  fontSize: 20
  color: hovered ? Theme.accent : Theme.fg

  onClicked: Quickshell.execDetached(["walker", "-n", "-m", "menus:power"])
}
