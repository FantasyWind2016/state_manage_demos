import 'package:mobx/mobx.dart';

import '../model/user_model.dart';

part 'account_model.g.dart';

enum AccountStatus {
  unlogin,
  login
}

class AccountModel = _AccountModel with _$AccountModel;
abstract class _AccountModel with Store {
  @observable
  UserModel userModel = UserModel();

  @observable
  String accountID;

  @observable
  String userName;

  @observable
  String password;

  @computed
  AccountStatus get accountStatus => (accountID != null && accountID.length > 0) ? AccountStatus.login : AccountStatus.unlogin;
}