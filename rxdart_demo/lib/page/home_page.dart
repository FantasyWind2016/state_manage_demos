import 'package:flutter/material.dart';
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
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return LoginPage();
    }));
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
              Icon(Icons.account_circle),
              Text(value.data.userName??''),
            ],
          )
        ),
      ]),
    );
  }
}
