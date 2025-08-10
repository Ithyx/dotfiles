import qs

MyText {
    default required property string name
    text: name

    font.family: Theme.iconFont
    font.pointSize: Theme.fontSizes.larger
    font.variableAxes: ({
            FILL: 0.0,
            GRAD: -25,
            opsz: fontInfo.pixelSize,
            wght: fontInfo.weight
        })
}
