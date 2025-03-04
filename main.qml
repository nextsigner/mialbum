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
    property var urls: fromCurl?['https://sourceforge.net/projects/zool/files/fotos_p1_v1.2.28.1.zip/download']:['https://liquidtelecom.dl.sourceforge.net/project/zool/fotos_p1_v1.2.28.1.zip?viasf=1']
    property int cUrlIndex: 0

    property bool fromCurl: false

    property bool autoNext: true
    property int cFotoIndex: 0
    property int maxFotoIndex: 0

    MouseArea{
        anchors.fill: parent
        onClicked: {
            //unik.get
            //run(10)
        }
    }
    Row{
        spacing: app.fs
        Text{
            id: txt0
            text: 'v5.7'
            //width: app.width-app.fs*4
            //wrapMode: Text.WrapAnywhere
            font.pixelSize: app.fs
            color: 'white'

        }
        Text{
            text: 'Foto '+parseInt(app.cFotoIndex+1)+' de '+img.aImgs.length
            //width: app.width-app.fs*4
            //wrapMode: Text.WrapAnywhere
            font.pixelSize: app.fs
            color: 'white'

        }

    }
    Text{
        id: txt1
        text: 'Cargando...'
        font.pixelSize: app.fs
        color: 'white'
        anchors.centerIn: parent
    }
    Image{
        id: img
        height: app.height
        fillMode: Image.PreserveAspectFit
        anchors.centerIn: parent
        property var aImgs: []
        Timer{
            id: tNext
            running: img.aImgs.length>0 && app.autoNext
            repeat: true
            interval: 8000
            onTriggered: {
                next()
            }
        }
    }


    Component.onCompleted: {
        downloadData()
    }




    Timer{
        running: !autoNext
        repeat: false
        interval: 30000
        onTriggered: {
            autoNext=true
        }
    }
    Shortcut{
        sequence: 'Return'
        onActivated: {
            app.autoNext=!app.autoNext
        }
    }
    Shortcut{
        sequence: 'Enter'
        onActivated: {
            app.autoNext=!app.autoNext
        }
    }
    Shortcut{
        sequence: 'Left'
        onActivated: {
            tNext.restart()
            prev()
        }
    }
    Shortcut{
        sequence: 'Right'
        onActivated: {
            tNext.restart()
            next()
        }
    }
    Connections{
        id: conn1
        target: curl
        property string zipFilePath: ''
        onFinalDownloadUrlReady:{
            //txt0.text+='Nueva url! '+finalUrl
            download(finalUrl, zipFilePath)
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
    function downloadData(){
        let d = new Date(Date.now())
        let ms=d.getTime()
        let zipFileName='zip_'+ms+'.zip'
        let zipFilePath=unik.getPath(4)+'/'+zipFileName
        let url=app.urls[app.cUrlIndex]
        if(app.fromCurl){
            conn1.zipFilePath=zipFilePath
            curl.getFinalDownloadUrl(app.urls[app.cUrlIndex]);
        }else{
            download(url, zipFilePath)
        }
    }
    function download(finalUrl, zipFilePath){
        console.log('finalUrl: '+finalUrl)
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
                    if(fl[i].indexOf('.jpg')>0 || fl[i].indexOf('.png')>0 || fl[i].indexOf('.JPG')>0 || fl[i].indexOf('.jpeg')>0 || fl[i].indexOf('.JPEG')>0 || fl[i].indexOf('.BMP')>0 || fl[i].indexOf('.bmp')>0 || fl[i].indexOf('.svg')>0){
                        a.push(fl[i])
                    }
                }
                console.log('a: '+a)
                img.aImgs=a
                //rep.model=a
            }else{
                //txt0.text+='\nNo Descomprimido! '
            }
        }else{
            txt0.text+='\nNO Descargado! '+zipFilePath
        }
    }
    function prev(){
        if(app.cFotoIndex>0){
            app.cFotoIndex--
        }else{
            app.cFotoIndex=img.aImgs.length-1
        }
        img.source="file://"+unik.getPath(4)+"/fotos_"+app.cUrlIndex+"/"+img.aImgs[app.cFotoIndex].replace(/ /g,"\%20")+""
    }
    function next(){
        if(app.cFotoIndex<img.aImgs.length){
            app.cFotoIndex++
        }else{
            app.cFotoIndex=0
        }
        img.source="file://"+unik.getPath(4)+"/fotos_"+app.cUrlIndex+"/"+img.aImgs[app.cFotoIndex].replace(/ /g,"\%20")+""
    }
}
