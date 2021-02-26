import 'package:bloc_demo/bloc/login_bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/account_model.dart';
import '../utils/account_manager.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: BlocProvider(
          create: (_) => LoginBloc(),
          child: _LoginPageBody(),
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
  void loginButtonPressed() {
    BlocProvider.of<LoginBloc>(context).add(CommitButtonClick());
  }

  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginInitial>(
      listener: (context, state) {
        if (state.loginSuccess) {
          AccountModel accountModel = AccountModel();
          accountModel.accountID = 'u123456';
          accountModel.userName = state.userName;
          accountModel.password = state.password;
          AccountManager.instance.saveInfo(accountModel);

          Navigator.of(context).pop();
        }
      },
      child:Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          children: <Widget>[
            Text('用户名：'),
            Expanded(
              child: TextField(
                controller: userNameController,
                onChanged: (value) {
                  context.bloc<LoginBloc>().add(UserNameChanged(userName: value));
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
                  BlocProvider.of<LoginBloc>(context).add(PasswordChanged(password: value));
                },
              ),
            )
          ],
        ),
        // 这里也可以去掉，然后把上面的BlocListener改为Consumer，但rebuild返回就变大了。
        BlocBuilder<LoginBloc, LoginInitial>(
          builder: (context, state) {
            return Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    onPressed: state.loginButtonEnabled ? loginButtonPressed : null,
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
            );
          }
        ),
      ]),
    );
  }
}
