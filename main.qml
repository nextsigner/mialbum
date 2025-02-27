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
            text: '8888'
            width: app.width-app.fs*4
            wrapMode: Text.WrapAnywhere
            font.pixelSize: app.fs
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
        //console.log(unikHere.log('Hola!'))
    }


    Timer{
        running: false//true
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
    Connections{
        target: curl
        onFinalDownloadUrlReady:{
            txt0.text+='Nueva url! '+finalUrl
            let downloaded=unik.downloadZipFile(finalUrl, zipFilePath)
            if(downloaded){
                txt0.text+='\nDescargado '+zipFilePath
                let zipFolderDestination=unik.getPath(4)+'/fotos'
                let unziped=unik.unzipFile(zipFilePath, zipFolderDestination)
                if(unziped){
                    txt0.text+='\nDescomprimido! '
                }else{
                    txt0.text+='\nNo Descomprimido! '
                }
            }else{
                txt0.text+='\nNO Descargado! '+zipFilePath
            }
        }
    }
    Shortcut{
        sequence: 'Up'
        onActivated: {
            let d = new Date(Date.now())
            let ms=d.getTime()
            let zipFileName='zip_'+ms+'.zip'
            let zipFilePath=unik.getPath(4)+'/'+zipFileName
            let url='https://sourceforge.net/projects/zool/files/fotos_v1.2.26.1.zip/download'
            //unik.log('Downloading zip: '+url)
            //unik.log('Downloading to zipFilePath: '+zipFilePath)
            txt0.text=url+'\n'+zipFilePath
            curl.getFinalDownloadUrl("https://sourceforge.net/projects/zool/files/fotos_v1.2.26.1.zip/download");
            //return

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
