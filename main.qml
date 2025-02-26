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
            text: '1111'
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
    Shortcut{
        sequence: 'Enter'
        onActivated: {
            run(11)
        }
    }
    Shortcut{
        sequence: 'Up'
        onActivated: {
            let a=ttsEngines
            txt0.text=a
            unik.ttsCurrentEngine=a[0]
        }
    }
    //engine.rootContext()->setContextProperty("ttsEngines", u.ttsEnginesList);
    //engine.rootContext()->setContextProperty("ttsVoices", u.ttsVoicesList);
    //engine.rootContext()->setContextProperty("ttsCurrentVoice", u.ttsCurrentVoice);
    //engine.rootContext()->setContextProperty("ttsLocales", u.ttsLocales);
    function run(v){
        txt1.text=' Probando texto '+v+' Probando texto '+v+' Probando texto '+v
        unik.speak(txt1.text, 'es-ES')
        txt1.text+='...'
    }
}
