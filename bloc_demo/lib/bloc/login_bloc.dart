import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginInitial> {
  @override
  LoginInitial get initialState => LoginInitial();

  @override
  void onTransition(Transition<LoginEvent, LoginInitial> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<LoginInitial> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is UserNameChanged) {
      yield state.copyWith(
        userName: event.userName,
        loginButtonEnabled:(event.userName != null && event.userName.length>0) && (state.password != null && state.password.length>4)
      );
    } else if (event is PasswordChanged) {
      yield state.copyWith(
        password: event.password,
        loginButtonEnabled:(state.userName != null && state.userName.length>0) && (event.password != null && event.password.length>4)
      );
    } else if (event is CommitButtonClick) {
      yield state.copyWith(loginSuccess: true);
    }
  }
}
