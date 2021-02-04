import 'package:flutter/material.dart';
import 'package:normal_demo/model/account_model.dart';
import 'package:normal_demo/model/user_model.dart';
import 'package:normal_demo/utils/account_manager.dart';

class ModifyUserInfoPage extends StatelessWidget {
  const ModifyUserInfoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Modify Name'),
        ),
        body: _ModifyUserInfoPageBody(),
      ),
    );
  }
}

class _ModifyUserInfoPageBody extends StatefulWidget {
  _ModifyUserInfoPageBody({Key key}) : super(key: key);

  @override
  _ModifyUserInfoPageBodyState createState() => _ModifyUserInfoPageBodyState();
}

class _ModifyUserInfoPageBodyState extends State<_ModifyUserInfoPageBody> {
  void confirmButtonPressed() {
    AccountModel accountModel = AccountManager.instance.accountModel;
    accountModel.userModel = UserModel();
    accountModel.userModel.name = nameController.text;
    AccountManager.instance.saveInfo(accountModel);

    Navigator.of(context).pop();
  }

  var nameController = TextEditingController();
  bool confirmButtonEnable = false;
  void onTextChanged(_){  
    setState(() {
      confirmButtonEnable = nameController.text != null && nameController.text.length>0 && nameController.text != AccountManager.instance.accountModel.userModel.name;
    });
  }
  @override
  void initState() {
    nameController.text = AccountManager.instance.accountModel.userModel.name;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          children: <Widget>[
            Text('姓名：'),
            Expanded(
              child: TextField(
                controller: nameController,
                onChanged: onTextChanged,
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: FlatButton(
                onPressed: confirmButtonEnable ? confirmButtonPressed : null,
                child: Text(
                  '修改',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.green[600],
                disabledColor: Colors.grey[400],
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
