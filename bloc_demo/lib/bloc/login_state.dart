part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {
  final String userName;
  final String password;
  final bool loginButtonEnabled;
  final bool loginSuccess;

  LoginInitial({
    this.userName,
    this.password,
    this.loginButtonEnabled = false,
    this.loginSuccess = false,
  });

  LoginInitial copyWith({
    String userName,
    String password,
    bool loginButtonEnabled,
    bool loginSuccess,
  }) {
    return LoginInitial(
      userName: userName ?? this.userName,
      password: password ?? this.password,
      loginButtonEnabled: loginButtonEnabled ?? this.loginButtonEnabled,
      loginSuccess: loginSuccess ?? this.loginSuccess,
    );
  }
}
