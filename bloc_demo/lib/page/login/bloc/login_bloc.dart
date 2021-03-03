import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => LoginState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is UserNameChanged) {
      yield state.copyWith(
        userName: event.userName,
      );
    } else if (event is PasswordChanged) {
      yield state.copyWith(
        password: event.password,
      );
    } else if (event is CommitButtonClick) {
      yield state.copyWith(loginSuccess: true);
    }
  }
}
