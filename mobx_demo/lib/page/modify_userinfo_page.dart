import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import '../model/account_model.dart';
import '../model/user_model.dart';
import '../utils/account_manager.dart';
import 'modify_userinfo_store.dart';

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
  var nameController = TextEditingController();
  var store = ModifyUserInfoStore();
  var confirmedReaction;

  @override
  void initState() {
    confirmedReaction = reaction((_)=>store.confirmed.value, (result){
      print('confirmed reaction');
      Navigator.of(context).pop();
    });
    nameController.text = store.name;
    super.initState();
  }

  @override
  void dispose() {
    confirmedReaction();
    super.dispose();
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
                onChanged: (value)=>store.name = value,
              ),
            )
          ],
        ),
        Observer(
          builder:(_) => Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  onPressed: store.confirmButtonEnable ? ()=>store.doConfirm() : null,
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
        ),
      ]),
    );
  }
}
