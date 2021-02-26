part of 'account_bloc.dart';

@immutable
abstract class AccountState {}

class AccountInitial extends AccountState {
  final String accountID;
  bool get unlogin => accountID == null || accountID.length==0;
  final String userName;
  final String password;
  final UserModel userModel;
  AccountInitial({
    this.accountID,
    this.userName,
    this.password,
    this.userModel,
  });
  AccountInitial copyWith({
    String accountID,
    String userName,
    String password,
    UserModel userModel,
  }) {
    return AccountInitial(
      accountID: accountID ?? this.accountID,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      userModel: userModel ?? this.userModel,
    );
  }
}
