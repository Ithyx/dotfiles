import QtQuick
import QtQuick.Layouts
import qs.utils
import qs

Item {
    id: root
    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Rectangle {
                anchors.fill: parent

                color: "transparent"
                border.color: Theme.palette.surface0
                border.width: 5
                topLeftRadius: Theme.radius
                topRightRadius: Theme.radius
            }

            Icon {
                id: icon
                name: "calendar_today"

                color: Theme.palette.accent

                anchors.centerIn: parent
            }
        }
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Rectangle {
                anchors.fill: parent
                color: Theme.palette.surface0
            }

            MyText {
                text: Time.hours + " " + Time.minutes

                color: Theme.palette.accent
                wrapMode: Text.WordWrap
                font.family: Theme.clockFont
                font.pointSize: Theme.fontSizes.larger

                anchors.left: parent.left
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}
