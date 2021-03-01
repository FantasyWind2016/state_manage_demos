import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../model/account_model.dart';
import 'login_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: StoreProvider(
          store: Store<LoginState>(loginReducer, initialState: LoginState()),
          child: _LoginPageBody()
        ),
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
  Store store;
  @override
  void initState() {
    store = StoreProvider.of<LoginState>(context, listen: false);
    store.onChange.listen((onData){
      if (onData is LoginState) {
        if (onData.commitSuccess) {
          Navigator.of(context).pop();
        }
      }
    });
    super.initState();
  }
  void loginButtonPressed() {
    store.dispatch(Commit(StoreProvider.of<AccountModel>(context, listen: false)));
  }

  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
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
                onChanged: (value){
                  store.dispatch(UserNameUpdate(value));
                },
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
                onChanged: (value){
                  store.dispatch(PasswordUpdate(value));
                },
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: StoreConnector<LoginState, bool>(
                converter: (store)=>store.state.commitButtonEnable,
                builder:(context, value) => FlatButton(
                  onPressed: value ? loginButtonPressed : null,
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
            ),
          ],
        ),
      ]),
    );
  }
}
