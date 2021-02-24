import 'package:mobx/mobx.dart';

part 'user_model.g.dart';

class UserModel = _UserModel with _$UserModel;
abstract class _UserModel with Store  {
  @observable
  String name;
}