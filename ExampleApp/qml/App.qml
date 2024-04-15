import QtQuick 2.15
import QtQuick.Controls.Material
import QtQuick.Layouts

Item {
    id: app

    StackView {
        id: stack
        anchors.fill: app
        initialItem: startPage
    }

    Pane {
        id: startPage
        visible: false

        anchors.fill: parent

        Label {
            id: lab
            anchors.centerIn: parent
            text: "Example App"
            font.pointSize: 18
        }

        Button {
            id: startApp
            x: lab.x + 20
            anchors.top: lab.bottom

            width: implicitWidth
            height: 45
            text: "START"

            onClicked: {
                stack.pop()
                stack.push(acc)
                acc.load()

            }
        }
    }



    Account {
        id: acc
        visible: false
    }

    AccountAdd {
        id: acc_add
        visible: false
    }

    Connections{
        target: acc
        function onAdd(){
            stack.push(acc_add)
        }
    }

    Connections{
        target: acc_add
        function onClose(){
            stack.pop()
        }
    }



}
