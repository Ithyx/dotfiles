pragma Singleton

import Quickshell
import QtQuick

Singleton {
    component MyPalette: QtObject {
        // Background pane
        required property color base
        // Secondary panes
        required property color crust
        required property color mantle
        // Surface elements
        required property color surface0
        required property color surface1
        required property color surface2
        // Text
        required property color text
        required property color subtext0
        required property color subtext1
        // Panels
        required property color accent
    }

    readonly property MyPalette catpuccinMocha: MyPalette {
        base: "#1e1e2e"

        crust: "#11111b"
        mantle: "#181825"

        surface0: "#313244"
        surface1: "#45475a"
        surface2: "#585b70"

        text: "#cdd6f4"
        subtext0: "#a6adc8"
        subtext1: "#bac2de"

        accent: "#f5c2e7" // pink
    }

    property var fontSizes: QtObject {
        property real scale: 1.5
        property int small: 5 * scale
        property int smaller: 7 * scale
        property int normal: 10 * scale
        property int larger: 12 * scale
        property int large: 15 * scale
    }

    readonly property string iconFont: "Material Symbols Rounded"
    readonly property string clockFont: "A-OTF Shin Go Pro"

    property MyPalette palette: catpuccinMocha

    readonly property real radius: 8
}
