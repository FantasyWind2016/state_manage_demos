part of 'modify_userinfo_bloc.dart';

@immutable
abstract class ModifyUserinfoState {}

class ModifyUserinfoInitial extends ModifyUserinfoState {
  final String name;
  final bool commitButtonEnabled;
  final bool commitSuccess;

  ModifyUserinfoInitial({
    this.name,
    this.commitButtonEnabled = false,
    this.commitSuccess = false,
  });

  ModifyUserinfoInitial copyWith({
    String name,
    bool commitButtonEnabled,
    bool commitSuccess,
  }) {
    return ModifyUserinfoInitial(
      name: name ?? this.name,
      commitButtonEnabled: commitButtonEnabled ?? this.commitButtonEnabled,
      commitSuccess: commitSuccess ?? this.commitSuccess,
    );
  }
}
