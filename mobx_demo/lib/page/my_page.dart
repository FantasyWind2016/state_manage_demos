import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../model/account_model.dart';
import '../page/login_page.dart';
import '../page/modify_userinfo_page.dart';
import '../utils/account_manager.dart';

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

  @override
  void initState() {
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
    AccountManager.instance.accountModel = AccountModel();
    AccountManager.instance.saveInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder:(_) => Column(children: [
        Visibility(
          visible: AccountManager.instance.accountModel.accountStatus==AccountStatus.unlogin,
          child: FlatButton(
            onPressed: unloginButtonPressed, 
            child: Text('用户未登录')
          ),
        ),
        Visibility(
          visible: AccountManager.instance.accountModel.accountStatus!=AccountStatus.unlogin,
          child: Row(
            children: <Widget>[
              Icon(Icons.account_circle, size: 44,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(AccountManager.instance.accountModel.userName??''),
                  Text(AccountManager.instance.accountModel.userModel?.name??''),
                ],
              ),
            ],
          )
        ),
        Visibility(
          visible: AccountManager.instance.accountModel.accountStatus!=AccountStatus.unlogin,
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
          visible: AccountManager.instance.accountModel.accountStatus!=AccountStatus.unlogin,
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