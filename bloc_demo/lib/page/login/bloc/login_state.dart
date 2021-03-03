part of 'login_bloc.dart';

class LoginState {
  final String userName;
  final String password;
  bool get loginButtonEnabled => (userName != null && userName.length>0) && (password != null && password.length>4);
  final bool loginSuccess;

  LoginState({
    this.userName,
    this.password,
    this.loginSuccess = false,
  });

  LoginState copyWith({
    String userName,
    String password,
    bool loginSuccess,
  }) {
    return LoginState(
      userName: userName ?? this.userName,
      password: password ?? this.password,
      loginSuccess: loginSuccess ?? this.loginSuccess,
    );
  }
}
