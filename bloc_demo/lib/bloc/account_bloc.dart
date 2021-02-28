import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_demo/model/user_model.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountInitial> {

  AccountInitial get initialState {
    SharedPreferences.getInstance().then((sf){
      var str = sf.getString('account_info');
      if (str==null || str.length==0) {
        return;
      }
      var value = jsonDecode(str);
      if (value!=null) {
        var userModelValue = value['userModel'];
        var userModel = UserModel();
        userModel.name = userModelValue['name'];
        add(AccountUpdate(
          accountID: value['accountID'],
          userName: value['userName'],
          password: value['password'],
          userModel: userModel,
        ));
      }
    });
    return AccountInitial();
  }
  @override
  Stream<AccountInitial> mapEventToState(
    AccountEvent event,
  ) async* {
    if (event is AccountUpdate) {
      var copy = state.copyWith(
        accountID: event.accountID,
        userName: event.userName,
        password: event.password,
        userModel: event.userModel,
      );
      var sf = await SharedPreferences.getInstance();
      sf.setString('account_info', jsonEncode({
        'accountID': copy.accountID,
        'userName': copy.userName,
        'password': copy.password,
        'userModel': {
          'name': copy.userModel?.name
        }
      }));
      yield copy;
    } if (event is AccountClear) {
      var sf = await SharedPreferences.getInstance();
      sf.setString('account_info', jsonEncode({
        'accountID': '',
        'userName': '',
        'password': '',
        'userModel': {
          'name': ''
        }
      }));
      yield AccountInitial();
    }
  }
}
