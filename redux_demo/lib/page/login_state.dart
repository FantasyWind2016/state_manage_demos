import 'package:redux/redux.dart';

import '../model/account_model.dart';

LoginState loginReducer(LoginState state, action) {
  if (action is UserNameUpdate) {
    return state.copyWith(userName: action.userName);
  } else if (action is PasswordUpdate) {
    return state.copyWith(password: action.password);
  } else if (action is Commit) {
    action.accountStore.dispatch(AccountUpdate(
      accountID: 'u123456',
      userName: state.userName,
      password: state.password,
    ));
    return state.copyWith(commitSuccess: true);
  }
  return state;
}

abstract class LoginAction{}

class UserNameUpdate implements LoginAction {
  String userName;
  UserNameUpdate(String value){
    userName = value;
  }
}

class PasswordUpdate implements LoginAction {
  String password;
  PasswordUpdate(String value){
    password = value;
  }
}

class Commit implements LoginAction {
  Store accountStore;
  Commit(Store store){
    accountStore = store;
  }
}

class LoginState {
  String userName;
  String password;
  bool get commitButtonEnable => (userName != null && userName.length>0) && (password != null && password.length>4);
  bool commitSuccess;

  LoginState({
    this.userName,
    this.password,
    this.commitSuccess = false,
  });

  LoginState copyWith({
    String userName,
    String password,
    bool commitSuccess,
  }) {
    return LoginState(
      userName: userName ?? this.userName,
      password: password ?? this.password,
      commitSuccess: commitSuccess ?? this.commitSuccess,
    );
  }
}