pragma Singleton

import Quickshell

Singleton {
    id: root

    readonly property string hours: Qt.formatDateTime(clock.date, "hh")
    readonly property string minutes: Qt.formatDateTime(clock.date, "mm")

    readonly property string readableTime: {
        Qt.formatDateTime(clock.date, "hh:mm | dd日 MM月 yyyy年");
    }
    readonly property string rawTime: clock.date

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
