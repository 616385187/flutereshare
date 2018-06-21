import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
class devicePage extends StatefulWidget{

  dynamic device;
  devicePage(this.device);

  @override
  _devicePageState createState() => new _devicePageState(device);

}
//jjj
class _devicePageState extends State<devicePage>{

  static const MethodChannel methodChannel = const MethodChannel('GET_DEVICE_CHANNEL');
  int _count=0;
  String _type ="";
  List<dynamic> date;
  Future<Null> _getFile(String type) async {
    print('33333333'+type);
    _type=type;
    int count;
    try {
      final String result = await methodChannel.invokeMethod('GET_DEVICE_CHANNEL_FILE',{"date":type});
      print(result);
      date =JSON.decode(result );
      count= date.length;
    } on PlatformException {
    }
    setState(() {
      _count = count;
    });
  }
  Future<Null> _openFile(String path) async {
    try {
      final String result = await methodChannel.invokeMethod('SHOWFILE',{"date":path});
      print(result);
    } on PlatformException {
    }
    setState(() {
    });
  }
  dynamic device;
  _devicePageState(this.device);

  @override
  Widget build(BuildContext context) {

    if(Platform.isIOS)
    {
      return new Material(

          child: new Scaffold(
              appBar: new AppBar(title: new Text("操作演示(点击投屏2)"),),
              body: new Container(
                child:
                new Column(mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new InkWell(child: new Card(child: new Center(child: new FlatButton(child: new Text("ios文件传送"),onPressed: ()=>_getFile("iosTrans"),),),),),
                    new InkWell(child: new Card(child: new Center(child: new FlatButton(child: new Text("获取图片"),onPressed: ()=>_getFile("jpg"),),),),),
                    new InkWell(child: new Card(child: new Center(child: new FlatButton(child: new Text("获取文件"),onPressed: ()=>_getFile("txt"),),),),),
                    new InkWell(child: new Card(child: new Center(child: new FlatButton(child: new Text("获取音频"),onPressed: ()=>_getFile("mp3"),),),),),
                    new InkWell(child: new Card(child: new Center(child: new FlatButton(child: new Text("获取视频"),onPressed: ()=>_getFile("mp4"),),),),),

                    new Container(height: 500.0-116.0,child: buildGrid(date,_type),)

                  ],),
              )

          )
      );
    }
    else if(Platform.isAndroid)
    {
      return new Material(

          child: new Scaffold(
              appBar: new AppBar(title: new Text("操作演示(点击投屏)"),),
              body: new Container(
                child:
                new Column(mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new InkWell(child: new Card(child: new Center(child: new FlatButton(child: new Text("获取图片"),onPressed: ()=>_getFile("jpg"),),),),),
                    new InkWell(child: new Card(child: new Center(child: new FlatButton(child: new Text("获取文件"),onPressed: ()=>_getFile("txt"),),),),),
                    new InkWell(child: new Card(child: new Center(child: new FlatButton(child: new Text("获取音频"),onPressed: ()=>_getFile("mp3"),),),),),
                    new InkWell(child: new Card(child: new Center(child: new FlatButton(child: new Text("获取视频"),onPressed: ()=>_getFile("mp4"),),),),),

                    new Container(height: 500.0-116.0,child: buildGrid(date,_type),)

                  ],),
              )


          )
      );
    }


  }

 Widget buildGrid(List<dynamic> date,String type) {
   return new GridView.extent(
       maxCrossAxisExtent: 150.0,
       padding: const EdgeInsets.all(4.0),
       mainAxisSpacing: 4.0,
       crossAxisSpacing: 4.0,
       children: _buildGridTileList(date,type)
   );
 }

  List<Container> _buildGridTileList(List<dynamic> date,String type) {

    return new List<Container>.generate(
        _count,
            (int index) => new Container(child:_getChild(index, date, type),)
    );
  }

  Widget _getChild(int index,List<dynamic> date,String type) {
    if(type=="jpg")
      return new InkWell(child: Image.file(new File(date[index]["path"])),onTap: ()=>_openFile(date[index]["path"]),);
    else
      return new InkWell(child: new Text(date[index]["name"]),onTap: ()=>_openFile(date[index]["path"]),);
  }
}



