import Quickshell

BarModule {
  property bool expanded: false

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }

  text: Qt.formatDateTime(clock.date, expanded ? "dddd, MMMM dd, yyyy | HH:mm:ss" : "MMMM dd | HH:mm:ss")

  onClicked: expanded = !expanded
}
