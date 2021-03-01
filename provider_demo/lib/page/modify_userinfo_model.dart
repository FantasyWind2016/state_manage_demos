import 'package:flutter/material.dart';

import '../model/account_model.dart';
import '../model/user_model.dart';
import '../utils/account_manager.dart';

class ModifyUserinfoModel with ChangeNotifier {
  String _name = AccountManager.instance.accountModel.userModel?.name;
  String get name {
    return _name;
  }
  set name(value) {
    _name = value;
    notifyListeners();
  }
  bool get commitButtonEnable => name != null && name.length>0 && name != AccountManager.instance.accountModel.userModel.name;
  bool _commitSuccess = false;
  get commitSuccess {
    return _commitSuccess;
  }
  set commitSuccess(value) {
    this._commitSuccess = value;
    notifyListeners();
  }
  void commit(){
    AccountModel accountModel = AccountManager.instance.accountModel;
    accountModel.userModel = UserModel();
    accountModel.userModel.name = name;
    AccountManager.instance.saveInfo(accountModel);
    commitSuccess = true;
  }
}