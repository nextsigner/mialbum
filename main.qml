import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Window 2.0

ApplicationWindow{
    id: app
    visible: true
    visibility: 'Maximized'
    color: 'black'
    width: 500
    height: 500
    property int fs: Screen.width*0.02
    MouseArea{
        anchors.fill: parent
        onClicked: {
            run()
        }
    }
    Text{
        id: txt1
        text: 'Prueba 3'
        font.pixelSize: app.fs*3
        color: 'white'
        anchors.centerIn: parent
    }

    Component.onCompleted: {
        console.log(unikHere.log('Hola!'))
    }

    Shortcut{
        sequence: 'Enter'
        onActivated: {
            run()
        }
    }
    function run(){
        txt1.text='Probando texto 1'
        unik.speak('Probando el texto a voz', 0)
        txt1.text='Probando texto 2'
    }
}
