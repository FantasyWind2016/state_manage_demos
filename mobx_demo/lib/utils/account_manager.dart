import 'dart:convert';
import 'package:mobx/mobx.dart';

import '../model/account_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'account_manager.g.dart';

class AccountManager extends _AccountManager with _$AccountManager {
  static AccountManager instance = AccountManager();


  Future<void> saveInfo () async {
    var sf = await SharedPreferences.getInstance();
    sf.setString('account_info', jsonEncode({
      'accountID': accountModel.accountID,
      'userName': accountModel.userName,
      'password': accountModel.password,
      'userModel': {
        'name': accountModel.userModel?.name
      }
    }));
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
        accountModel.userModel.name = userModelValue['name'];
      }
    });
  }
}
abstract class _AccountManager with Store {
  @observable
  AccountModel accountModel = AccountModel();
}