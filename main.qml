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
            //unik.get
            //run(10)
        }
    }
    Column{
        spacing: 30
        //anchors.centerIn: parent
        Text{
            id: txt0
            text: '0000'
            font.pixelSize: app.fs*3
            color: 'white'

        }
        Text{
            id: txt1
            text: 'Prueba 3'
            font.pixelSize: app.fs*3
            color: 'white'

        }
    }
    Component.onCompleted: {
        console.log(unikHere.log('Hola!'))
    }

    Shortcut{
        sequence: 'Enter'
        onActivated: {
            run(11)
        }
    }
    Timer{
        running: true
        repeat: true
        interval: 3000
        property int v: 1
        onTriggered: {
            run(v)
            v++
        }
    }
    function run(v){
        txt1.text=' Probando texto '+v+' Probando texto '+v+' Probando texto '+v
        unik.speak(txt1.text)
        txt1.text+='...'
    }
}
