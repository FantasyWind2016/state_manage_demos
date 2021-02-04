import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:normal_demo/model/account_model.dart';
import 'package:normal_demo/page/login_page.dart';
import 'package:normal_demo/utils/account_manager.dart';
import 'package:normal_demo/utils/event_bus_util.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('home'),
        ),
        body: _HomePageBody(),
      ),
    );
  }
}

class _HomePageBody extends StatefulWidget {
  _HomePageBody({Key key}) : super(key: key);

  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<_HomePageBody> {
  bool showUnloginButton;
  String userName;
  void refreshState() {
    showUnloginButton = AccountManager.instance.accountModel.accountID == null ||
        AccountManager.instance.accountModel.accountID.length == 0;
    userName = AccountManager.instance.accountModel.userName;
  }

  @override
  void initState() {
    refreshState();
    EventBusUtil.instance.on<AccountModelUpdatedEvent>().listen((onData) {
      setState(() {
        refreshState();
      });
    });
    super.initState();
  }

  void unloginButtonPressed() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return LoginPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Visibility(
          visible: showUnloginButton,
          child: FlatButton(
            onPressed: unloginButtonPressed, 
            child: Text('用户未登录')
          ),
        ),
        Visibility(
          visible: !showUnloginButton,
          child: Row(
            children: <Widget>[
              Icon(Icons.account_circle),
              Text(userName??''),
            ],
          )
        ),
      ]),
    );
  }
}
