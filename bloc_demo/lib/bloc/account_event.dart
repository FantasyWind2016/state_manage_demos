part of 'account_bloc.dart';

@immutable
abstract class AccountEvent {}

class AccountUpdate extends AccountEvent {
  final String accountID;
  final String userName;
  final String password;
  final UserModel userModel;
  AccountUpdate({
    this.accountID,
    this.userName,
    this.password,
    this.userModel,
  });
}

class AccountClear extends AccountEvent {
  
}