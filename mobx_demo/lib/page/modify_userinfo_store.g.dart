// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modify_userinfo_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ModifyUserInfoStore on _ModifyUserInfoStore, Store {
  Computed<bool> _$confirmButtonEnableComputed;

  @override
  bool get confirmButtonEnable => (_$confirmButtonEnableComputed ??=
          Computed<bool>(() => super.confirmButtonEnable,
              name: '_ModifyUserInfoStore.confirmButtonEnable'))
      .value;

  final _$nameAtom = Atom(name: '_ModifyUserInfoStore.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$_ModifyUserInfoStoreActionController =
      ActionController(name: '_ModifyUserInfoStore');

  @override
  void doConfirm() {
    final _$actionInfo = _$_ModifyUserInfoStoreActionController.startAction(
        name: '_ModifyUserInfoStore.doConfirm');
    try {
      return super.doConfirm();
    } finally {
      _$_ModifyUserInfoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
confirmButtonEnable: ${confirmButtonEnable}
    ''';
  }
}
