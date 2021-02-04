import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_demo/model/account_model.dart';

import 'modify_userinfo_controller.dart';

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

class _ModifyUserInfoPageBody extends StatelessWidget {
  final controller = ModifyUserInfoController();

  final nameController = TextEditingController();
  _ModifyUserInfoPageBody({Key key}) : super(key: key) {
    nameController.text = AccountModel.to.userModel?.name;
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
                onChanged: controller.updateName,
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            GetBuilder(
              init: controller,
              builder: (_) => Expanded(
                child: FlatButton(
                  onPressed: _.confirmButtonEnable ? _.confirmButtonPressed : null,
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
            ),
          ],
        ),
      ]),
    );
  }
}
