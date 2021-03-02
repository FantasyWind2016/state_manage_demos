import 'package:flutter/material.dart';
import 'modify_userinfo_viewmodel.dart';

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
  var viewmodel = ModifyUserinfoViewmodel();
  var nameController = TextEditingController();
  @override
  void initState() {
    nameController.text = viewmodel.initialName;
    viewmodel.commitSuccessSubject.listen((onData){
      if (onData) {
        Navigator.of(context).pop();
      }
    });
    super.initState();
  }
  
  void confirmButtonPressed() {
    viewmodel.commit();
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
                onChanged: (value){
                  viewmodel.nameSubject.add(value);
                },
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: StreamBuilder(
                stream: viewmodel.commitButtonEnableSubject,
                builder:(context, value) => FlatButton(
                  onPressed: value?.data??false ? confirmButtonPressed : null,
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
