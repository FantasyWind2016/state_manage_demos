// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on _LoginStore, Store {
  Computed<bool> _$loginButtonEnableComputed;

  @override
  bool get loginButtonEnable => (_$loginButtonEnableComputed ??= Computed<bool>(
          () => super.loginButtonEnable,
          name: '_LoginStore.loginButtonEnable'))
      .value;

  final _$userNameAtom = Atom(name: '_LoginStore.userName');

  @override
  dynamic get userName {
    _$userNameAtom.reportRead();
    return super.userName;
  }

  @override
  set userName(dynamic value) {
    _$userNameAtom.reportWrite(value, super.userName, () {
      super.userName = value;
    });
  }

  final _$passwordAtom = Atom(name: '_LoginStore.password');

  @override
  dynamic get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(dynamic value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$_LoginStoreActionController = ActionController(name: '_LoginStore');

  @override
  void doConfirm() {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.doConfirm');
    try {
      return super.doConfirm();
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userName: ${userName},
password: ${password},
loginButtonEnable: ${loginButtonEnable}
    ''';
  }
}
