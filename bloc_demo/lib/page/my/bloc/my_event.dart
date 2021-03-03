part of 'my_bloc.dart';

@immutable
abstract class MyEvent {}

class ModifySuccessEvent extends MyEvent {
  final bool value;
  ModifySuccessEvent({
    this.value
  });
}
