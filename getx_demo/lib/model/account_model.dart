import 'package:get/get.dart';
import 'package:getx_demo/model/user_model.dart';

enum AccountStatus {
  unlogin, // 未登录
  login, // 已登录
}

class AccountModel extends GetController {
  static AccountModel get to => Get.find();
  
  UserModel userModel;
  String accountID;
  AccountStatus get status => accountID==null || accountID.length==0 ? AccountStatus.unlogin : AccountStatus.login;
  String userName;
  String password;
}