import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'my_event.dart';
part 'my_state.dart';

class MyBloc extends Bloc<MyEvent, MyState> {
  @override
  MyState get initialState => MyState();

  @override
  Stream<MyState> mapEventToState(
    MyEvent event,
  ) async* {
    if (event is ModifySuccessEvent) {
      yield MyState(modifySuccess: event.value);
    }
    yield state;
  }
}
