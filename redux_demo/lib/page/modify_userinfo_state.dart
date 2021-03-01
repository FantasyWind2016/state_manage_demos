import 'package:redux/redux.dart';

import '../model/account_model.dart';
import '../model/user_model.dart';

ModifyUserinfoState modifyUserinfoReducer(ModifyUserinfoState state, action) {
  if (action is NameUpdate) {
    return state.copyWith(name: action.name);
  } else if (action is Commit) {
    var userModel = UserModel();
    userModel.name = state.name;
    action.accountStore.dispatch(AccountUpdate(userModel: userModel));
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
  Store accountStore;
  Commit(Store store){
    accountStore = store;
  }
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