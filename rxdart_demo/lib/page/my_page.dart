import 'package:flutter/material.dart';
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
    return StreamBuilder<AccountModel>(
      initialData: AccountManager.instance.accountModelSubject.value,
      stream: AccountManager.instance.accountModelSubject,
      builder:(context, value) => Column(children: [
        Visibility(
          visible: value.data.isUnlogin,
          child: FlatButton(
            onPressed: unloginButtonPressed, 
            child: Text('用户未登录')
          ),
        ),
        Visibility(
          visible: !value.data.isUnlogin,
          child: Row(
            children: <Widget>[
              Icon(Icons.account_circle, size: 44,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(value.data.userName??''),
                  Text(value.data.userModel?.name??''),
                ],
              ),
            ],
          )
        ),
        Visibility(
          visible: !value.data.isUnlogin,
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
          visible: !value.data.isUnlogin,
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