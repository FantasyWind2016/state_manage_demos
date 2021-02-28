import 'package:flutter/material.dart';
import '../model/account_model.dart';
import '../page/login_page.dart';
import '../page/modify_userinfo_page.dart';
import '../utils/account_manager.dart';
import '../utils/event_bus_util.dart';

class MyPage extends StatelessWidget {
  final String title;
  const MyPage({Key key,this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(this.title),
        ),
        body: _MyPageBody(),
      ),
    );
  }
}

class _MyPageBody extends StatefulWidget {
  _MyPageBody({Key key}) : super(key: key);

  @override
  _MyPageBodyState createState() => _MyPageBodyState();
}

class _MyPageBodyState extends State<_MyPageBody> {
  bool showLogoutButton;
  String userName;
  String name;
  void refreshState() {
    showLogoutButton = !(AccountManager.instance.accountModel.accountID == null ||
        AccountManager.instance.accountModel.accountID.length == 0);
    userName = AccountManager.instance.accountModel?.userName;
    name = AccountManager.instance.accountModel?.userModel?.name;
  }

  @override
  void initState() {
    refreshState();
    EventBusUtil.instance.on<AccountModelUpdatedEvent>().listen((onData) {
      if (!mounted) {
        return;
      }
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

  void modifyNameButtonPressed() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return ModifyUserInfoPage();
    }));
  }
  
  void logoutButtonPressed() {
    AccountModel accountModel = AccountModel();
    AccountManager.instance.saveInfo(accountModel);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Visibility(
          visible: !showLogoutButton,
          child: FlatButton(
            onPressed: unloginButtonPressed, 
            child: Text('用户未登录')
          ),
        ),
        Visibility(
          visible: showLogoutButton,
          child: Row(
            children: <Widget>[
              Icon(Icons.account_circle, size: 44,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(userName??''),
                  Text(name??''),
                ],
              ),
            ],
          )
        ),
        Visibility(
          visible: showLogoutButton,
          child: Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  onPressed: modifyNameButtonPressed,
                  child: Text(
                    '修改姓名',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.blue[100],
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: showLogoutButton,
          child: Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  onPressed: logoutButtonPressed,
                  child: Text(
                    '退出登录',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}