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

    Text{
        id: txt1
        text: 'Prueba'
        font.pixelSize: app.fs
        color: 'white'
        anchors.centerIn: parent
    }

    Component.onCompleted: {
        console.log(unikHere.log('Hola!'))
    }

    Shortcut{
        sequence: 'Enter'
        onActivated: {
            txt1.text='Probando texto 1'
            unik.speak('Probando el texto a voz')
            txt1.text='Probando texto 2'
        }
    }
}
