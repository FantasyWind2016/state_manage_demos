import 'package:mobx/mobx.dart';

import '../model/account_model.dart';
import '../model/user_model.dart';
import '../utils/account_manager.dart';

part 'modify_userinfo_store.g.dart';

class ModifyUserInfoStore = _ModifyUserInfoStore with _$ModifyUserInfoStore;

abstract class _ModifyUserInfoStore with Store {
  var confirmed = Observable(1);
  @computed
  bool get confirmButtonEnable => name != null && name.length>0 && name != AccountManager.instance.accountModel.userModel?.name;
  @observable
  String name = AccountManager.instance.accountModel.userModel?.name;
  @action
  void doConfirm() {
    AccountModel accountModel = AccountManager.instance.accountModel;
    accountModel.userModel = UserModel();
    accountModel.userModel.name = name;
    AccountManager.instance.saveInfo(accountModel);

    confirmed.value++;
  }
}