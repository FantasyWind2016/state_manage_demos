import '../model/user_model.dart';

class AccountModelUpdatedEvent {
  
}

class AccountModel {
  UserModel userModel;
  String accountID;
  bool get isUnlogin => accountID==null || accountID.length==0;
  String userName;
  String password;
}