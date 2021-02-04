import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'login_controller.dart';

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

class _LoginPageBody extends StatelessWidget {
  final controller = LoginController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  _LoginPageBody({Key key}) : super(key: key);

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
                onChanged: controller.updateUserName,
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
                onChanged: controller.updatePassword,
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            GetBuilder(
              init: controller,
              builder: (_) => Expanded(
                child: FlatButton(
                  onPressed: _.loginButtonEnable ? _.loginButtonPressed : null,
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
