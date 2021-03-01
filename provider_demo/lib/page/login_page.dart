import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/account_model.dart';
import 'login_model.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: ChangeNotifierProvider<LoginModel>(
          create: (_)=>LoginModel(),
          child: _LoginPageBody()
        ),
      ),
    );
  }
}

class _LoginPageBody extends StatelessWidget {
  _LoginPageBody({Key key}) : super(key: key);
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  loginButtonPressed(){
    Provider.of<LoginModel>(aContext, listen: false).commit(Provider.of<AccountModel>(aContext, listen: false));
  }
  BuildContext aContext;
  @override
  Widget build(BuildContext context) {
    aContext = context;
    return Consumer<LoginModel>(
      builder:(context, model, child) {
        if (model.commitSuccess) {
          Future((){
            Navigator.of(context).pop();
          });
        }
        return child;
      },
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          children: <Widget>[
            Text('用户名：'),
            Expanded(
              child: TextField(
                controller: userNameController,
                onChanged: (value) {
                  Provider.of<LoginModel>(context, listen: false).userName = value;
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
                  Provider.of<LoginModel>(context, listen: false).password = value;
                },
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Selector<LoginModel, bool>(
                selector: (context, model) => model.commitButtonEnable,
                shouldRebuild: (pre, next) => pre!=next,
                builder:(context, value, child) {
                  // 刷新时，只有FlatButton会被rebuild
                  return FlatButton(
                    onPressed: value ? loginButtonPressed : null,
                    child: child,
                    color: Colors.green[600],
                    disabledColor: Colors.grey[400],
                  );
                },
                child: Text(
                  '登录',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
