import 'package:flutter/material.dart';
import 'login_viewmodel.dart';

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
  var viewmodel = LoginViewModel();

  @override
  void initState() {
    viewmodel.commitSuccessSubject.listen((onData){
      if (onData) {
        Navigator.of(context).pop();
      }
    });
    super.initState();
  }

  void loginButtonPressed() {
    viewmodel.commit();
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
                  viewmodel.unSubject.add(value);
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
                onChanged: (value) {
                  viewmodel.psSubject.add(value);
                },
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: StreamBuilder<bool>(
                stream: viewmodel.commitButtonEnableSubject.stream,
                builder:(context, value) => FlatButton(
                  onPressed: value?.data??false ? loginButtonPressed : null,
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
