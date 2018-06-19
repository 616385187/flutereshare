import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;
  List<String> _devices ;
  var _pageController = new PageController(initialPage: 0);
  static const MethodChannel methodChannel = const MethodChannel("GET_DEVICE_CHANNEL");
  Future<Null> _getDevices () async {
    try{
      _devices = await methodChannel.invokeMethod("getdevices");
      print(_devices);
    }on PlatformException{

    }
    setState(() {
    });
  }
  void _pageChange(int index) {
    setState(() {
      if (_currentPageIndex != index) {
        _currentPageIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("eshare示例"),
        centerTitle: true,
      ),
      body: new PageView.builder(
        onPageChanged:_pageChange,
        controller: _pageController,
        itemBuilder: (BuildContext context,int index){
          return index==1?new Text("我是第一页"):new Text("我是其他页面");
        },
        itemCount: 2,

      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: new Icon(Icons.category), title: new Text("设备连接")),
          BottomNavigationBarItem(
              icon: new Icon(Icons.message), title: new Text("投屏操作")),
        ],
        currentIndex: _currentPageIndex,
        onTap: (int index){
          //_pageController.jumpToPage(index); 没有动画的页面切换
          _pageController.animateToPage(index, duration: new Duration(seconds: 2),curve:new ElasticOutCurve(0.8));
          _pageChange(index);
        },
      ),
    );
  }
//  Widget _buildStockList(BuildContext context, Iterable<Stock> stocks, StockHomeTab tab) {
//    return new StockList(
//      stocks: stocks.toList(),
//      onAction: _buyStock,
//      onOpen: (Stock stock) {
//        Navigator.pushNamed(context, '/stock:${stock.symbol}');
//      },
//      onShow: (Stock stock) {
//        _scaffoldKey.currentState.showBottomSheet<Null>((BuildContext context) => new StockSymbolBottomSheet(stock: stock));
//      },
//    );
//  }
  Widget _getEshareDevicelist(BuildContext context,List<String>devices ){
    return new ListView.builder(itemCount: devices.length,
        itemBuilder: (BuildContext con,int indext){
          return new Container(child: new Text(devices[indext]),);
        });
  }
}
void main(){
  runApp(
    new MaterialApp(
      title: 'Flutter教程',
      home: new HomePage(),
    ),
  );
}