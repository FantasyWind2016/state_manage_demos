import 'package:flutter/material.dart';
import 'package:normal_demo/model/account_model.dart';
import 'package:normal_demo/model/user_model.dart';
import 'package:normal_demo/utils/account_manager.dart';

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
  void loginButtonPressed() {
    AccountModel accountModel = AccountModel();
    accountModel.accountID = 'u123456';
    accountModel.userName = userNameController.text;
    accountModel.password = passwordController.text;
    accountModel.userModel = UserModel();
    accountModel.userModel.name = '张三';
    AccountManager.instance.saveInfo(accountModel);

    Navigator.of(context).pop();
  }

  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  bool loginButtonEnable = false;
  void onTextChanged(_){  
    setState(() {
      loginButtonEnable = (userNameController.text != null && userNameController.text.length>0) && (passwordController.text != null && passwordController.text.length>4);
    });
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
                onChanged: onTextChanged,
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
                onChanged: onTextChanged,
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: FlatButton(
                onPressed: loginButtonEnable ? loginButtonPressed : null,
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
      ]),
    );
  }
}
