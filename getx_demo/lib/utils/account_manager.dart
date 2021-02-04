import 'dart:convert';

import 'package:getx_demo/model/account_model.dart';
import 'package:getx_demo/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountManager {
  static AccountManager instance = AccountManager();
  
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
      AccountModel accountModel = AccountModel.to;
      accountModel.accountID = model.accountID;
      accountModel.userName = model.userName;
      accountModel.password = model.password;
      accountModel.userModel = model.userModel;
      accountModel.update(accountModel);
    // });
  }

  void loadInfo() {
    SharedPreferences.getInstance().then((sf){
      var str = sf.getString('account_info');
      var value = jsonDecode(str);
      if (value!=null) {
        AccountModel accountModel = AccountModel.to;
        accountModel.accountID = value['accountID'];
        accountModel.userName = value['userName'];
        accountModel.password = value['password'];
        var userModelValue = value['userModel'];
        accountModel.userModel = UserModel();
        accountModel.userModel.name = userModelValue['name'];
        accountModel.update(accountModel);
      }
    });
  }
}