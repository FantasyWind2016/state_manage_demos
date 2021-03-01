import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';

import '../model/user_model.dart';

AccountModel accountReducer(AccountModel state, action) {
  if (action is AccountUpdate) {
    var result = state.copyWith(
      userModel: action.userModel,
      accountID: action.accountID,
      userName: action.userName,
      password: action.password,
    );
    SharedPreferences.getInstance().then((sf){
      sf.setString('account_info', jsonEncode({
        'accountID': result.accountID,
        'userName': result.userName,
        'password': result.password,
        'userModel': {
          'name': result?.userModel?.name
        }
      }));
    });
    return result;
  } else if (action is AccountClear) {
    SharedPreferences.getInstance().then((sf){
      sf.setString('account_info', jsonEncode({
        'accountID': '',
        'userName': '',
        'password': '',
        'userModel': {
          'name': ''
        }
      }));
    });
    return AccountModel();
  } else if (action is AccountModel) {
    return action;
  }
  return state;
}

abstract class AccountAction{}

ThunkAction<AccountModel> asyncLoadAccount(){
  return (Store<AccountModel> store) async {
    var sf = await SharedPreferences.getInstance();
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
      store.dispatch(accountModel);
    }
  };
}

class AccountUpdate implements AccountAction {
  UserModel userModel;
  String accountID;
  String userName;
  String password;
  AccountUpdate({
    this.userModel,
    this.accountID,
    this.userName,
    this.password,
  });
}

class AccountClear implements AccountAction {
  
}

class AccountModel {
  UserModel userModel;
  String accountID;
  bool get isUnlogin => accountID == null || accountID.length == 0;
  String userName;
  String password;

  AccountModel({
    this.userModel,
    this.accountID,
    this.userName,
    this.password,
  });

  AccountModel copyWith({
    UserModel userModel,
    String accountID,
    String userName,
    String password,
  }) {
    return AccountModel(
      userModel: userModel ?? this.userModel,
      accountID: accountID ?? this.accountID,
      userName: userName ?? this.userName,
      password: password ?? this.password,
    );
  }
}