import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:getx_demo/utils/account_manager.dart';
import 'package:getx_demo/model/account_model.dart';
import 'package:getx_demo/model/user_model.dart';

class ModifyUserInfoController extends GetController {

  bool confirmButtonEnable = false;
  var name = AccountModel.to.userModel?.name;
  void updateName (value) {
    name = value;
    confirmButtonEnable = name != null && name.length>0 && name != AccountModel.to.userModel?.name;
    update(this);
  }
  void confirmButtonPressed() {
    AccountModel accountModel = AccountModel.to;
    accountModel.userModel = UserModel();
    accountModel.userModel.name = name;
    AccountManager.instance.saveInfo(accountModel);
    Navigator.of(context).pop();
    Get.back();
  }
}