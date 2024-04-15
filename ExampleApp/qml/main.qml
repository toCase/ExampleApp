import QtQuick
import QtQuick.Window
import QtQuick.Controls.Material

Window {
    width: 900
    height: 480
    visible: true
    title: qsTr("Example App")

    App {
        anchors.fill: parent
        anchors.margins: 15
    }
}
