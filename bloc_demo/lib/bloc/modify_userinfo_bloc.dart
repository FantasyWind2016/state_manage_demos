import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../utils/account_manager.dart';

part 'modify_userinfo_event.dart';
part 'modify_userinfo_state.dart';

class ModifyUserinfoBloc extends Bloc<ModifyUserinfoEvent, ModifyUserinfoInitial> {
  ModifyUserinfoInitial get initialState => ModifyUserinfoInitial(name: AccountManager.instance.accountModel.userModel.name);

  @override
  Stream<ModifyUserinfoInitial> mapEventToState(
    ModifyUserinfoEvent event,
  ) async* {
    if (event is NameChanged) {
      yield state.copyWith(
        name: event.name,
        commitButtonEnabled: event.name != null && event.name.length>0 && event.name != AccountManager.instance.accountModel.userModel.name
      );
    } else if (event is CommitButtonClick) {
      yield state.copyWith(commitSuccess: true);
    }
  }
}
