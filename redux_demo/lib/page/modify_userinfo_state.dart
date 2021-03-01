import 'package:redux_demo/model/user_model.dart';

import '../model/account_model.dart';
import '../utils/account_manager.dart';

ModifyUserinfoState modifyUserinfoReducer(ModifyUserinfoState state, action) {
  if (action is NameUpdate) {
    return state.copyWith(name: action.name);
  } else if (action is Commit) {
    AccountModel accountModel = AccountManager.instance.accountModel;
    accountModel.userModel = UserModel();
    accountModel.userModel.name = state.name;
    AccountManager.instance.saveInfo(accountModel);

    return state.copyWith(commitSuccess: true);
  }
  return state;
}

abstract class ModifyUserinfoAction{}

class NameUpdate implements ModifyUserinfoAction {
  String name;
  NameUpdate(String value){
    name = value;
  }
}

class Commit implements ModifyUserinfoAction {
  
}

class ModifyUserinfoState {
  String initialName;
  String name;
  bool get commitButtonEnable => (name != null && name.length>0) && (name != initialName);
  bool commitSuccess;

  ModifyUserinfoState({
    this.initialName,
    this.name,
    this.commitSuccess = false,
  });

  ModifyUserinfoState copyWith({
    String initialName,
    String name,
    bool commitSuccess,
  }) {
    return ModifyUserinfoState(
      initialName: initialName ?? this.initialName,
      name: name ?? this.name,
      commitSuccess: commitSuccess ?? this.commitSuccess,
    );
  }
}