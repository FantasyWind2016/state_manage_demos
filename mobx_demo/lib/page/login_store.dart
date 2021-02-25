import 'package:mobx/mobx.dart';

import '../model/account_model.dart';
import '../utils/account_manager.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  @observable
  var userName;

  @observable
  var password;

  @computed
  bool get loginButtonEnable => (userName != null && userName.length>0) && (password != null && password.length>4);

  var confirmed = Observable(false);
  @action
  void doConfirm(){
    print('doConfirm');
    AccountModel accountModel = AccountManager.instance.accountModel;
    accountModel.accountID = 'u123456';
    accountModel.userName = userName;
    accountModel.password = password;
    AccountManager.instance.saveInfo();

    confirmed.value = true;
  }
}