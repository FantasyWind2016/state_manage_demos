import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/account_model.dart';
import '../page/login_page.dart';
import '../page/modify_userinfo_page.dart';

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
    Provider.of<AccountModel>(context, listen: false).save(AccountModel(false));
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AccountModel>(
      builder:(context, model, child) => Column(children: [
        Visibility(
          visible: model.isUnlogin,
          child: FlatButton(
            onPressed: unloginButtonPressed, 
            child: Text('用户未登录')
          ),
        ),
        Visibility(
          visible: !model.isUnlogin,
          child: Row(
            children: <Widget>[
              Icon(Icons.account_circle, size: 44,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(model.userName??''),
                  Text(model.userModel?.name??''),
                ],
              ),
            ],
          )
        ),
        Visibility(
          visible: !model.isUnlogin,
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
          visible: !model.isUnlogin,
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