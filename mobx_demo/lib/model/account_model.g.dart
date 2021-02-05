// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AccountModel on _AccountModel, Store {
  Computed<AccountStatus> _$accountStatusComputed;

  @override
  AccountStatus get accountStatus => (_$accountStatusComputed ??=
          Computed<AccountStatus>(() => super.accountStatus,
              name: '_AccountModel.accountStatus'))
      .value;

  final _$userModelAtom = Atom(name: '_AccountModel.userModel');

  @override
  UserModel get userModel {
    _$userModelAtom.reportRead();
    return super.userModel;
  }

  @override
  set userModel(UserModel value) {
    _$userModelAtom.reportWrite(value, super.userModel, () {
      super.userModel = value;
    });
  }

  final _$accountIDAtom = Atom(name: '_AccountModel.accountID');

  @override
  String get accountID {
    _$accountIDAtom.reportRead();
    return super.accountID;
  }

  @override
  set accountID(String value) {
    _$accountIDAtom.reportWrite(value, super.accountID, () {
      super.accountID = value;
    });
  }

  final _$userNameAtom = Atom(name: '_AccountModel.userName');

  @override
  String get userName {
    _$userNameAtom.reportRead();
    return super.userName;
  }

  @override
  set userName(String value) {
    _$userNameAtom.reportWrite(value, super.userName, () {
      super.userName = value;
    });
  }

  final _$passwordAtom = Atom(name: '_AccountModel.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  @override
  String toString() {
    return '''
userModel: ${userModel},
accountID: ${accountID},
userName: ${userName},
password: ${password},
accountStatus: ${accountStatus}
    ''';
  }
}
