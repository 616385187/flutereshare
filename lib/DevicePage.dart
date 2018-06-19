import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
class devicePage extends StatefulWidget{

  dynamic device;
  devicePage(this.device);

  @override
  _devicePageState createState() => new _devicePageState(device);

}
//jjj
class _devicePageState extends State<devicePage>{

  static const MethodChannel methodChannel = const MethodChannel('GET_DEVICE_CHANNEL');
  dynamic device;


  _devicePageState(this.device);
  @override
  Widget build(BuildContext context) {
    
    return new Material(

      child: new Scaffold(
        appBar: new AppBar(title: new Text("操作演示(点击投屏)"),),
        body: new Container(
          child:
        new Column(mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new InkWell(child: new Card(child: new Center(child: new FlatButton(child: new Text("获取图片"),onPressed: _getImage(),),),),),
            new InkWell(child: new Card(child: new Center(child: new FlatButton(child: new Text("获取文件"),onPressed: null,),),),),
            new InkWell(child: new Card(child: new Center(child: new FlatButton(child: new Text("获取音频"),onPressed: null,),),),),
            new InkWell(child: new Card(child: new Center(child: new FlatButton(child: new Text("获取视频"),onPressed: null,),),),),

            new Container(height: 500.0-116.0,child: buildGrid(),)

          ],),
          )


      )
    );
  }

 Widget buildGrid() {
   return new GridView.extent(
       maxCrossAxisExtent: 150.0,
       padding: const EdgeInsets.all(4.0),
       mainAxisSpacing: 4.0,
       crossAxisSpacing: 4.0,
       children: _buildGridTileList(20)
   );
 }

  List<Container> _buildGridTileList(int count) {
    return new List<Container>.generate(
        count,
            (int index) => new Container(child: new Text("a"))
    );
  }
}

_getImage() {
  methodChannel
}
