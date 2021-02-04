import 'package:get/get.dart';
import 'package:getx_demo/model/account_model.dart';
import 'package:getx_demo/utils/account_manager.dart';

class LoginController extends GetController {
  bool loginButtonEnable = false;
  var userName;
  var password;
  void updateUserName(value) {
    userName = value;
    onTextChanged();
  }
  void updatePassword(value) {
    password = value;
    onTextChanged();
  }
  void loginButtonPressed() {
    AccountModel accountModel = AccountModel();
    accountModel.accountID = 'u123456';
    accountModel.userName = userName;
    accountModel.password = password;
    AccountManager.instance.saveInfo(accountModel);

    Get.back();
  }

  void onTextChanged(){  
    loginButtonEnable = (userName != null && userName.length>0) && (password != null && password.length>4);
    update(this);
  }
  
}