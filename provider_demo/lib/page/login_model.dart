import 'package:flutter/material.dart';
import '../model/account_model.dart';

class LoginModel with ChangeNotifier {
  String _userName;
  get userName {
    return _userName;
  }
  set userName(value) {
    this._userName = value;
    notifyListeners();
  }
  String _password;
  get password {
    return _password;
  }
  set password(value) {
    this._password = value;
    notifyListeners();
  }
  bool get commitButtonEnable => (userName!=null&&userName.length>0) && (password!=null&&password.length>4);
  bool _commitSuccess = false;
  get commitSuccess {
    return _commitSuccess;
  }
  set commitSuccess(value) {
    this._commitSuccess = value;
    notifyListeners();
  }
  void commit(AccountModel account){
    AccountModel accountModel = AccountModel(false);
    accountModel.accountID = 'u123456';
    accountModel.userName = userName;
    accountModel.password = password;
    account.save(accountModel);
    commitSuccess = true;
  }
}