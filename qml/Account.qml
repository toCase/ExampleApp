import QtQuick 2.15
import QtQuick.Controls.Material
import QtQuick.Layouts

Item {

    signal add()

    function load(){
        modelAccount.loadData()
    }

    Connections{
        target: modelAccount
        function onStarted(){
            console.log('---start---')
            prog.visible = true
            prog.value = 0
        }
        function onWorking(val){
            console.log(val)
            prog.value = val
        }
        function onFinished(){
            console.log('---fin---')
            prog.visible = false
        }

    }




    ColumnLayout{
        anchors.fill: parent
        spacing: 15

        RowLayout {
            Layout.fillWidth: true
            Layout.minimumHeight: implicitHeight
            Layout.maximumHeight: implicitHeight

            spacing: 5

            Button {
                id:but_add
                Layout.minimumHeight: 40
                Layout.maximumHeight: 40
                Layout.minimumWidth: implicitWidth
                Layout.maximumWidth: implicitWidth

                text: "ADD"

                onClicked: add()

            }
            Item {
                Layout.fillWidth: true
            }
            Button {
                id:but_upd
                Layout.minimumHeight: 40
                Layout.maximumHeight: 40
                Layout.minimumWidth: implicitWidth
                Layout.maximumWidth: implicitWidth

                text: "UPDATE"

                onClicked: load()
            }
        }
        ProgressBar {
            id: prog
            Layout.fillWidth: true
            Layout.minimumHeight: 7
            Layout.maximumHeight: 7
            visible: false
            value: 0
            from: 0
            to: 1
        }

        ListView {
            id: view
            Layout.fillWidth: true
            Layout.fillHeight: true

            model: modelAccount

            delegate: Item {
                width: view.width
                height: 40

                RowLayout {
                    anchors.fill: parent
                    spacing: 10

                    CheckBox {
                        Layout.fillHeight: true
                        checked: check == 1 ? true : false
                        enabled: status == "Active" ? true : false
                    }

                    Label {
                        Layout.fillHeight: true
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150

                        text: type
                        verticalAlignment: Qt.AlignVCenter
                    }
                    Label {
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        text: name
                        verticalAlignment: Qt.AlignVCenter
                    }
                    Label {
                        Layout.fillHeight: true
                        Layout.minimumWidth: 200
                        Layout.maximumWidth: 200

                        text: status
                        color: status == "Active" ? "#1E6649" : "#c90000"
                        font.italic: true
                        verticalAlignment: Qt.AlignVCenter
                    }
                    Label {
                        Layout.fillHeight: true
                        Layout.minimumWidth: 200
                        Layout.maximumWidth: 200

                        text: status == "Active" ? balance + " $" : ""
                        verticalAlignment: Qt.AlignVCenter
                    }
                    ToolButton {
                        Layout.fillHeight: true
                        Layout.minimumWidth: implicitWidth
                        Layout.maximumWidth: implicitWidth

                        // text: "DEL"
                        icon.source: "../img/trash"
                        icon.width: 18
                        icon.height: 18

                        onClicked: modelAccount.deleteAccount(index)
                    }
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.minimumHeight: implicitHeight
            Layout.maximumHeight: implicitHeight

            spacing: 5

            Button {
                id:but_selectAll
                Layout.minimumHeight: 40
                Layout.maximumHeight: 40
                Layout.minimumWidth: implicitWidth
                Layout.maximumWidth: implicitWidth

                text: "SELECT ALL"
                onClicked: modelAccount.selectAll()

            }
            Item {
                Layout.fillWidth: true
            }
            Button {
                id:but_connect
                Layout.minimumHeight: 40
                Layout.maximumHeight: 40
                Layout.minimumWidth: implicitWidth
                Layout.maximumWidth: implicitWidth

                text: "OPEN"
            }
            Button {
                id:but_disconnect
                Layout.minimumHeight: 40
                Layout.maximumHeight: 40
                Layout.minimumWidth: implicitWidth
                Layout.maximumWidth: implicitWidth

                text: "CLOSE ALL"
                onClicked: modelAccount.closeAll()
            }
        }
    }







}
