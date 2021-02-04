import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:getx_demo/model/account_model.dart';
import 'package:getx_demo/page/login_page.dart';

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

class _HomePageBody extends StatelessWidget {
  _HomePageBody({Key key}) : super(key: key);

  void unloginButtonPressed() {
    Get.to(LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<AccountModel>(
        builder: (_) => Column(children: [
          Visibility(
            visible: _.status == AccountStatus.unlogin,
            child: FlatButton(
              onPressed: unloginButtonPressed, 
              child: Text('用户未登录')
            ),
          ),
          Visibility(
            visible: _.status != AccountStatus.unlogin,
            child: Row(
              children: <Widget>[
                Icon(Icons.account_circle),
                Text(_.userName??'')
              ],
            )
          ),
        ]),
      ),
    );
  }
}
