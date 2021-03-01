import 'package:flutter/material.dart';

import '../model/account_model.dart';
import '../model/user_model.dart';

class ModifyUserinfoModel with ChangeNotifier {
  final String initialName;
  ModifyUserinfoModel({
    this.initialName,
  });
  String _name;
  String get name {
    return _name;
  }
  set name(value) {
    _name = value;
    notifyListeners();
  }
  bool get commitButtonEnable => name != null && name.length>0 && name != initialName;
  bool _commitSuccess = false;
  get commitSuccess {
    return _commitSuccess;
  }
  set commitSuccess(value) {
    this._commitSuccess = value;
    notifyListeners();
  }
  void commit(AccountModel model){
    model.userModel = UserModel();
    model.userModel.name = name;
    model.save(model);
    commitSuccess = true;
  }
}