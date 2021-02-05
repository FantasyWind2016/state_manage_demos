import 'dart:convert';

import '../model/account_model.dart';
import '../model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountManager {
  static AccountManager instance = AccountManager();
  AccountModel accountModel = AccountModel();

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
      accountModel.accountID = model.accountID;
      accountModel.userName = model.userName;
      accountModel.password = model.password;
      accountModel.userModel = model.userModel;
    // });
  }

  void loadInfo() {
    SharedPreferences.getInstance().then((sf){
      var str = sf.getString('account_info');
      var value;
      if (str!=null && str.length>0) {
        value = jsonDecode(str);
      }
      
      if (value!=null) {
        accountModel.accountID = value['accountID'];
        accountModel.userName = value['userName'];
        accountModel.password = value['password'];
        var userModelValue = value['userModel'];
        var userModel = UserModel();
        userModel.name = userModelValue['name'];
        accountModel.userModel = userModel;
      }
    });
  }
}