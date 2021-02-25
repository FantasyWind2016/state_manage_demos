import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../model/account_model.dart';
import '../page/login_page.dart';
import '../utils/account_manager.dart';

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

  void unloginButtonPressed() {
    AccountManager.instance.accountModel.accountID = '11';
    AccountManager.instance.accountModel.userName = '11';
    // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
    //   return LoginPage();
    // }));
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
              Icon(Icons.account_circle),
              Text(AccountManager.instance.accountModel.userName??''),
            ],
          )
        ),
      ]),
    );
  }
}
