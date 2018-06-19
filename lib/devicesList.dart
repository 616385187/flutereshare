import 'dart:async';
import 'dart:convert' ;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'DevicePage.dart';
import 'device.dart';
class PlatformChannel extends StatefulWidget {
  @override
  _PlatformChannelState createState() => new _PlatformChannelState();
}

class _PlatformChannelState extends State<PlatformChannel> {
  static const MethodChannel methodChannel =
  const MethodChannel('GET_DEVICE_CHANNEL');
//  static const EventChannel eventChannel =
//  const EventChannel('samples.flutter.io/charging');

  String _batteryLevel = 'Battery level: unknown.';
  String _chargingStatus = 'Battery status: unknown.';
  List<dynamic>  devices = new List() ;
  List<String> names =new List();
  Future<Null> _getBatteryLevel() async {

    String batteryLevel;
    try {
      devices.clear();
      final String result = await methodChannel.invokeMethod('GET_DEVICE_CHANNEL_Fx');
      print(result);
//      JsonDecoder decoder = new JsonDecoder();
//      List<dynamic>  a = decoder.convert(result);
      //json原来是这么玩的
//      print(a[0].forEach((key, value) => print("$key=$value")));
//      print(a[0]["a"]);
      devices = JSON.decode(result );
      devices[0].forEach((key,value) => print("$value"));
      print(devices.toString());

      batteryLevel = devices.toString();
    } on PlatformException {
      batteryLevel = 'Failed to get battery level.';
    }
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }
  Future<Null> _tryToConnect(dynamic devices) async {
    String batteryLevel;
    print(json.encode(devices));
    try {
      final String result = await methodChannel.invokeMethod('GET_DEVICE_CHANNEL_TRYTOCONNECT',{"date":json.encode(devices)});
      if(result=="ok"){
        print(result);

        Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
          return new devicePage(devices);
        }));

      }

    } on PlatformException {
      batteryLevel = 'Failed to get battery level.';
    }
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    _getBatteryLevel();
//    eventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
  }

//  void _onEvent(Object event) {
//    setState(() {
//      _chargingStatus =
//      "Battery status: ${event == 'charging' ? '' : 'dis'}charging.";
//    });
//  }
//
//  void _onError(Object error) {
//    setState(() {
//      _chargingStatus = 'Battery status: unknown.';
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(centerTitle: true,title: new Text("可连接设备"),),
        floatingActionButton: new FloatingActionButton(
          onPressed: _getBatteryLevel,
          tooltip: 'Create company',
          child: const Icon(Icons.find_replace),
          backgroundColor: Theme.of(context).accentColor,
        ),
        body: new ListView.builder(
          itemBuilder: (BuildContext context, int index) =>_builditem(context,index),

          itemCount: devices.length,

        ),

      ),


//      child:
//      new Column(
//        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//        children: <Widget>[
//          new Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//             new Container(
//               child: new ListView.builder(
//                itemBuilder: (BuildContext context, int index) =>
//                new Text(devices[index].toString()),
//                itemCount: devices.length,
//                 controller: new ScrollController(),
//              ),
//             ),
//              new Text(_batteryLevel, key: const Key('Battery level label')),
////              new Padding(
////                padding: const EdgeInsets.all(16.0),
////                child: new RaisedButton(
////                  child: const Text('Refresh'),
////                  onPressed: _getBatteryLevel,
////                ),
////              ),
//            ],
//          ),
//          new Text(_chargingStatus),
//
//      new FloatingActionButton(
//        onPressed: _getBatteryLevel,
//        tooltip: 'Create company',
//        child: const Icon(Icons.find_replace),
//        backgroundColor: Theme.of(context).accentColor,
//      )
//        ],
//      ),
    );
  }

  Widget _builditem(BuildContext context,int index) {

    return new InkWell(onTap: ()=> showDialog<Null>(context: context,child: new AlertDialog(actions: <Widget>[new FlatButton(onPressed: ()=>_tryToConnect(devices[index]), child: new Text("确定"))],title: new Text("提示"),content: new Text("确认连接："+devices[index]["a"]+"  ?"),)),
      child: new Card(child: new Padding(child: new Text(devices[index].toString()),padding: new EdgeInsets.all(10.0),),elevation: 20.0,margin: new EdgeInsets.all(20.0),shape:  ShapeBorder.lerp(null, null, 15.0),),);

  }

  void _showAlterdio() {
    showDialog<Null>(context: context,child: new AlertDialog(actions: <Widget>[new FlatButton(onPressed: null, child: new Text("确定"))],title: new Text("呵呵"),content: new Text("哈哈"),));
  }
}
Widget _getEshareDevicelist(List<dynamic>devices ){
  return new ListView.builder(itemCount: devices.length,

      itemBuilder: (BuildContext con,int indext){
        return new Container(child: new Text(devices[indext]),);
      });
}
void main() {
  runApp(new MaterialApp(home: new PlatformChannel()));
}
