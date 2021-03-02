import 'package:rxdart/rxdart.dart';
import '../utils/account_manager.dart';
import '../model/account_model.dart';
import '../model/user_model.dart';

class ModifyUserinfoViewmodel {
  ModifyUserinfoViewmodel(){
    nameSubject.listen((onData){
      commitButtonEnableSubject.add(onData != null && onData.length>0 && onData != initialName);
    });
  }
  dispose(){
    nameSubject.close();
    commitButtonEnableSubject.close();
    commitSuccessSubject.close();
  }
  String initialName = AccountManager.instance.accountModelSubject.value?.userModel?.name;
  BehaviorSubject<String> nameSubject = BehaviorSubject.seeded('');
  BehaviorSubject<bool> commitButtonEnableSubject = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> commitSuccessSubject = BehaviorSubject.seeded(false);
  commit(){
    AccountModel accountModel = AccountManager.instance.accountModelSubject.value;
    accountModel.userModel = UserModel();
    accountModel.userModel.name = nameSubject.value;
    AccountManager.instance.saveInfo(accountModel);

    commitSuccessSubject.add(true);
  }
}