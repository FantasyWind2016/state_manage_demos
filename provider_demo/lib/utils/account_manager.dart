import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/account_model.dart';
import '../model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../utils/event_bus_util.dart';

class AccountManager with ChangeNotifier {
  static AccountManager instance = AccountManager();
  AccountManager(){
    loadInfo();
  }
  AccountModel accountModel = AccountModel(false);

  Future<void> saveInfo (AccountModel model) async {
    var sf = await SharedPreferences.getInstance();
    // 此处使用promise语法，在退出登录的时候then不会触发
    // fut.then((sf){
      sf.setString('account_info', jsonEncode({
        'accountID': model.accountID,
        'userName': model.userName,
        'password': model.password,
        'userModel': {
          'name': model.userModel?.name
        }
      }));
      accountModel = model;
      notifyListeners();
      // EventBusUtil.instance.fire(AccountModelUpdatedEvent());
    // });
  }

  void loadInfo() {
    SharedPreferences.getInstance().then((sf){
      var str = sf.getString('account_info');
      if (str == null || str.length==0) {
        return;
      }
      var value = jsonDecode(str);
      if (value!=null) {
        accountModel = AccountModel(false);
        accountModel.accountID = value['accountID'];
        accountModel.userName = value['userName'];
        accountModel.password = value['password'];
        var userModelValue = value['userModel'];
        accountModel.userModel = UserModel();
        accountModel.userModel.name = userModelValue['name'];
      }
      notifyListeners();
      // EventBusUtil.instance.fire(AccountModelUpdatedEvent());
    });
  }
}