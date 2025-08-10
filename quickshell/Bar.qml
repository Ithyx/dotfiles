pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.time
import qs

Scope {
    id: root
    property int margin: 6

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

            color: "transparent"
            anchors {
                top: true
                right: true
                bottom: true
            }
            implicitWidth: 50

            Rectangle {
                anchors.fill: parent

                topLeftRadius: Theme.radius + root.margin
                bottomLeftRadius: Theme.radius
                color: Theme.palette.mantle
            }

            Item {
                anchors.fill: parent
                MarginWrapperManager {
                    margin: root.margin
                }

                ColumnLayout {
                    Clock {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }
                }
            }
        }
    }
}
