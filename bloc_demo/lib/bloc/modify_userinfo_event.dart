part of 'modify_userinfo_bloc.dart';

@immutable
abstract class ModifyUserinfoEvent {}

class NameChanged extends ModifyUserinfoEvent {
  final String name;
  NameChanged({
    this.name,
  });
}

class CommitButtonClick extends ModifyUserinfoEvent {
  
}
