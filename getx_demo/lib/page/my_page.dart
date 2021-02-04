import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:getx_demo/model/account_model.dart';
import 'package:getx_demo/page/login_page.dart';
import 'package:getx_demo/page/modify_userinfo_page.dart';
import 'package:getx_demo/utils/account_manager.dart';

class MyPage extends StatelessWidget {
  final String title;
  const MyPage({Key key,this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(this.title),
        ),
        body: _MyPageBody(),
      ),
    );
  }
}

class _MyPageBody extends StatelessWidget {
  _MyPageBody({Key key}) : super(key: key);

  void unloginButtonPressed() {
    Get.to(LoginPage());
  }

  void modifyNameButtonPressed() {
    Get.to(ModifyUserInfoPage());
  }
  
  void logoutButtonPressed() {
    AccountModel accountModel = AccountModel();
    AccountManager.instance.saveInfo(accountModel);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<AccountModel>(
        builder:(_) => Column(children: [
          Visibility(
            visible: _.status==AccountStatus.unlogin,
            child: FlatButton(
              onPressed: unloginButtonPressed, 
              child: Text('用户未登录')
            ),
          ),
          Visibility(
            visible: _.status!=AccountStatus.unlogin,
            child: Row(
              children: <Widget>[
                Icon(Icons.account_circle, size: 44,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(_.userName??''),
                    Text(_.userModel?.name??''),
                  ],
                ),
              ],
            )
          ),
          Visibility(
            visible: _.status!=AccountStatus.unlogin,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    onPressed: modifyNameButtonPressed,
                    child: Text(
                      '修改姓名',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.blue[100],
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: _.status!=AccountStatus.unlogin,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    onPressed: logoutButtonPressed,
                    child: Text(
                      '退出登录',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}