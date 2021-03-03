import 'package:flutter/material.dart';
import '../page/home_page.dart';
import '../page/my/my_page.dart';

class RootPage extends StatefulWidget {

  String tabName;

  static const String HomeTab = "HomeTab";
  static const String MyTab = "MyTab";

  RootPage({
    String tabName
  }) : this.tabName = tabName;

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> with SingleTickerProviderStateMixin {

  TabController _controller;
  var _index = 0;

  @override
  void initState(){
      super.initState();
      _controller = new TabController(length: 2, vsync: this);
      _controller.addListener((){
        setState(() {
          _index = _controller.index;
        });
      });

      if(widget.tabName != null && widget.tabName.isNotEmpty) {
        switch(widget.tabName) {
          case RootPage.HomeTab:
            _controller.index = 0;
            break;
          case RootPage.MyTab:
            _controller.index = 1;
            break;
        }
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: TabBarView(
          controller: _controller,
          children: <Widget>[
            HomePage(),
            MyPage(title: '我的',)
          ],
        ),
        bottomNavigationBar: Container(
          height: 60,
          child: TabBar(
            labelStyle: TextStyle(
              fontSize: 11,
            ),
            controller: _controller,
            tabs: <Widget>[
              Tab(
                text: "首页",
                icon: _index == 0 ? Icon(Icons.home, color: Color(0xffffba0a),) : Icon(Icons.home)
              ),
              Tab(
                text: "我的",
                icon: _index == 1 ? Icon(Icons.account_box, color: Color(0xffffba0a),) : Icon(Icons.account_box)
              )
            ],
          ),
        ),
          
        );
  }
}