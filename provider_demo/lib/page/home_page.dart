import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/account_model.dart';
import '../page/login_page.dart';

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
              Icon(Icons.account_circle),
              Text(model.userName??''),
            ],
          )
        ),
      ]),
    );
  }
}
