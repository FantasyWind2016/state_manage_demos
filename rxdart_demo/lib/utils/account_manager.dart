import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';

import '../model/account_model.dart';
import '../model/user_model.dart';

class AccountManager {
  static AccountManager instance = AccountManager();
  BehaviorSubject<AccountModel> accountModelSubject = BehaviorSubject.seeded(AccountModel());
  dispose(){
    accountModelSubject.close();
  }

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
      accountModelSubject.add(model);
  }

  void loadInfo() {
    SharedPreferences.getInstance().then((sf){
      var str = sf.getString('account_info');
      if (str==null || str.length==0) {
        return;
      }
      var value = jsonDecode(str);
      if (value!=null) {
        var accountModel = AccountModel();
        accountModel.accountID = value['accountID'];
        accountModel.userName = value['userName'];
        accountModel.password = value['password'];
        var userModelValue = value['userModel'];
        accountModel.userModel = UserModel();
        accountModel.userModel.name = userModelValue['name'];
        accountModelSubject.add(accountModel);
      }
    });
  }
}