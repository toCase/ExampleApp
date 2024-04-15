import QtQuick 2.15
import QtQuick.Controls.Material

import QtQuick.Layouts

Item {

    signal close()


    QtObject{
        id: internal

        function save(){
            let l = []
            l[0] = card_name.text
            l[1] = card_type.currentText
            l[2] = card_api.text
            l[3] = card_key.text

            console.log(l)
            modelAccount.add(l)
            close()
        }
    }




    ColumnLayout{
        anchors.fill: parent

        spacing: 10

        RowLayout {
            Layout.fillWidth: true
            Layout.minimumHeight: 40
            Layout.maximumHeight: 40
            spacing: 15

            Button{
                id: but_close
                text: "<"
                onClicked: close()

            }

            Item{

                Layout.fillWidth: true
            }

        }

        RowLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true

            Layout.leftMargin: parent.width / 4
            Layout.rightMargin: parent.width / 4

            ColumnLayout {
                width: implicitWidth
                height: implicitHeight
                anchors.centerIn: parent
                spacing: 10

                RowLayout {
                    Layout.fillWidth: true
                    Layout.minimumHeight: 40
                    Layout.maximumHeight: 40
                    spacing: 15

                    Label{
                        Layout.fillHeight: true
                        Layout.minimumWidth: 100
                        Layout.maximumWidth: 100

                        text: "NAME:"
                        horizontalAlignment: Qt.AlignRight
                        verticalAlignment: Qt.AlignVCenter
                    }

                    TextField {
                        id: card_name
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }

                }
                RowLayout {
                    Layout.fillWidth: true
                    Layout.minimumHeight: 40
                    Layout.maximumHeight: 40
                    spacing: 15

                    Label{
                        Layout.fillHeight: true
                        Layout.minimumWidth: 100
                        Layout.maximumWidth: 100

                        text: "TYPE:"
                        horizontalAlignment: Qt.AlignRight
                        verticalAlignment: Qt.AlignVCenter
                    }

                    ComboBox {
                        id: card_type
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        model: ['bybit', 'binance']
                    }

                }
                RowLayout {
                    Layout.fillWidth: true
                    Layout.minimumHeight: 40
                    Layout.maximumHeight: 40
                    spacing: 15

                    Label{
                        Layout.fillHeight: true
                        Layout.minimumWidth: 100
                        Layout.maximumWidth: 100

                        text: "KEY:"
                        horizontalAlignment: Qt.AlignRight
                        verticalAlignment: Qt.AlignVCenter
                    }

                    TextField {
                        id: card_api
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }

                }
                RowLayout {
                    Layout.fillWidth: true
                    Layout.minimumHeight: 40
                    Layout.maximumHeight: 40
                    spacing: 15

                    Label{
                        Layout.fillHeight: true
                        Layout.minimumWidth: 100
                        Layout.maximumWidth: 100

                        text: "SECRET:"
                        horizontalAlignment: Qt.AlignRight
                        verticalAlignment: Qt.AlignVCenter
                    }

                    TextField {
                        id: card_key
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }

                }
                RowLayout {
                    Layout.fillWidth: true
                    Layout.minimumHeight: 40
                    Layout.maximumHeight: 40
                    spacing: 15


                    Item{

                        Layout.fillWidth: true
                    }
                    Button{
                        id: but_save
                        text: "SAVE"
                        onClicked: internal.save()

                    }
                }
            }
        }
    }
}
