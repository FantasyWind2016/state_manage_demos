import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

class AccountModelUpdatedEvent {
  
}

class AccountModel with ChangeNotifier {
  AccountModel(bool needLoad){
    if (needLoad) {
      SharedPreferences.getInstance().then((sf){
        var str = sf.getString('account_info');
        if (str == null || str.length==0) {
          return;
        }
        var value = jsonDecode(str);
        if (value!=null) {
          accountID = value['accountID'];
          userName = value['userName'];
          password = value['password'];
          var userModelValue = value['userModel'];
          userModel = UserModel();
          userModel.name = userModelValue['name'];
          notifyListeners();
        }
      });
    }
  }
  bool get isUnlogin => accountID==null || accountID.length==0;
  UserModel userModel;
  String accountID;
  String userName;
  String password;
  save(AccountModel model) {
    SharedPreferences.getInstance().then((sf){
      var data = {
        'accountID': model?.accountID,
        'userName': model?.userName,
        'password': model?.password,
        'userModel': {
          'name': model?.userModel?.name
        }
      };
      sf.setString('account_info', jsonEncode(data));
      accountID = model?.accountID;
      userName = model?.userName;
      password = model?.password;
      userModel = model?.userModel;
      notifyListeners();
    });
  }
}