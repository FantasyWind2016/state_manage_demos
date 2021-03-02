import 'package:rxdart/rxdart.dart';
import '../model/account_model.dart';
import '../utils/account_manager.dart';

class LoginViewModel {
  LoginViewModel(){
    CombineLatestStream.combine2(
      unSubject,
      psSubject,
      (a, b) => a!=null&&a.length>0&&b!=null&&b.length>4,
    ).listen((onData){
      print('combine2$onData');
      commitButtonEnableSubject.add(onData);
    });
  }
  dispose(){
    unSubject.close();
    psSubject.close();
    commitButtonEnableSubject.close();
    commitSuccessSubject.close();
  }
  BehaviorSubject<String> unSubject = BehaviorSubject.seeded('');
  BehaviorSubject<String> psSubject = BehaviorSubject.seeded('');
  BehaviorSubject<bool> commitButtonEnableSubject = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> commitSuccessSubject = BehaviorSubject.seeded(false);
  commit(){
    AccountModel accountModel = AccountModel();
    accountModel.accountID = 'u123456';
    accountModel.userName = unSubject.value;
    accountModel.password = psSubject.value;
    AccountManager.instance.saveInfo(accountModel);

    commitSuccessSubject.add(true);
  }
}