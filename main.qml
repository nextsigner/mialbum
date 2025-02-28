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
    property var urls: ['https://sourceforge.net/projects/zool/files/fotos_v1.2.26.1.zip/download']
    property int cUrlIndex: 0
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
            text: '7777'
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
    Grid{
        id: grid
        anchors.centerIn: parent
        Repeater{
            id: rep
            Rectangle{
                width: 400
                height: width
                color: 'transparent'
                border.width: 2
                border.color: 'red'
                Image{
                    source: "file://"+unik.getPath(4)+"fotos_"+app.cUrlIndex+"/"+modelData.replace(/ /g,"\%20")+""
                    anchors.fill: parent
                    Timer{
                        running: true
                        repeat: true
                        interval: 2000
                        onTriggered: console.log('image'+index+': '+parent.source)
                    }

                }
            }
        }
    }

    Component.onCompleted: {
        dowloadData()
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
        id: conn1
        target: curl
        property string zipFilePath: ''
        onFinalDownloadUrlReady:{
            //txt0.text+='Nueva url! '+finalUrl
            let downloaded=unik.downloadZipFile(finalUrl, zipFilePath)
            if(downloaded){
                //txt0.text+='\nDescargado '+zipFilePath
                let zipFolderDestination=unik.getPath(4)+'/fotos_'+app.cUrlIndex
                unik.clearDir(zipFolderDestination)
                unik.mkdir(zipFolderDestination)

                /*let fileList=unik.getFileList(zipFolderDestination, ['*.jpg'], false)
                for(var i=0;i<fileList.length;i++){
                    unik.deleteFile(zipFolderDestination+'/'+fileList[i], ['*.jpg'], false)
                }*/

                let unziped=unik.unzipFile(zipFilePath, zipFolderDestination)
                if(unziped){
                    //txt0.text+='\nDescomprimido! '
                    let fl=unik.getFileList(zipFolderDestination, ['*.jpg'], false)
                    console.log('fl: '+fl)
                    let a=[]
                    for(var i=0;i<fl.length;i++){
                        a.push(fl[i])
                    }
                    console.log('a: '+a)
                    rep.model=a
                }else{
                    //txt0.text+='\nNo Descomprimido! '
                }
            }else{
                txt0.text+='\nNO Descargado! '+zipFilePath
            }
        }
    }
    Shortcut{
        sequence: 'Up'
        onActivated: {
//            let d = new Date(Date.now())
//            let ms=d.getTime()
//            let zipFileName='zip_'+ms+'.zip'
//            let zipFilePath=unik.getPath(4)+'/'+zipFileName
//            let url='https://sourceforge.net/projects/zool/files/fotos_v1.2.26.1.zip/download'
//            //unik.log('Downloading zip: '+url)
//            //unik.log('Downloading to zipFilePath: '+zipFilePath)
//            txt0.text=url+'\n'+zipFilePath
//            conn1.zipFilePath=zipFilePath
//            curl.getFinalDownloadUrl("https://sourceforge.net/projects/zool/files/fotos_v1.2.26.1.zip/download");

            //return

        }
    }
    function run(v){
        txt1.text=' Probando texto '+v+' Probando texto '+v+' Probando texto '+v
        unik.speak(txt1.text, 'es-ES')
        txt1.text+='...'
    }
    function dowloadData(){
        let d = new Date(Date.now())
        let ms=d.getTime()
        let zipFileName='zip_'+ms+'.zip'
        let zipFilePath=unik.getPath(4)+'/'+zipFileName
        let url=app.urls[app.cUrlIndex]
        conn1.zipFilePath=zipFilePath
        curl.getFinalDownloadUrl("https://sourceforge.net/projects/zool/files/fotos_v1.2.26.1.zip/download");

    }
}
