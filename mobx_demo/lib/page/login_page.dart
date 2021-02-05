import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import '../model/account_model.dart';
import '../model/user_model.dart';
import '../utils/account_manager.dart';
import 'login_store.dart';
class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: _LoginPageBody(),
      ),
    );
  }
}

class _LoginPageBody extends StatefulWidget {
  _LoginPageBody({Key key}) : super(key: key);

  @override
  _LoginPageBodyState createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<_LoginPageBody> {
  var store = LoginStore();
  var confirmedReaction;
  
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
    confirmedReaction = reaction((_)=>store.confirmed.value, (result){
      print('confirmed reaction');
      Navigator.of(context).pop();
    });
    super.initState();
  }

  @override
  void dispose() {
    confirmedReaction();
    super.dispose();
  }

  void loginButtonPressed() {
    print('loginButtonPressed');
    store.doConfirm();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          children: <Widget>[
            Text('用户名：'),
            Expanded(
              child: TextField(
                controller: userNameController,
                onChanged: (value) => store.userName=value,
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Text('密码：'),
            Expanded(
              child: TextField(
                controller: passwordController,
                onChanged: (value) => store.password=value,
              ),
            )
          ],
        ),
        Observer(
          builder: (_) => Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  onPressed: store.loginButtonEnable ? loginButtonPressed : null,
                  child: Text(
                    '登录',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.green[600],
                  disabledColor: Colors.grey[400],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
