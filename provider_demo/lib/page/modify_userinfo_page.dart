import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/account_manager.dart';
import 'modify_userinfo_model.dart';

class ModifyUserInfoPage extends StatelessWidget {
  const ModifyUserInfoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Modify Name'),
        ),
        body: ChangeNotifierProvider(
          create: (_)=>ModifyUserinfoModel(),
          child: _ModifyUserInfoPageBody()
        ),
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
    Provider.of<ModifyUserinfoModel>(context, listen: false).commit();
  }

  var nameController = TextEditingController();
  @override
  void initState() {
    nameController.text = Provider.of<ModifyUserinfoModel>(context, listen: false).name;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ModifyUserinfoModel>(
      builder: (context, model, child) {
        if (model.commitSuccess) {
          Future((){
            Navigator.of(context).pop();
          });
        }
        return child;
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, 
        children: [
          Row(
            children: <Widget>[
              Text('姓名：'),
              Expanded(
                child: TextField(
                  controller: nameController,
                  onChanged: (value){
                    Provider.of<ModifyUserinfoModel>(context, listen: false).name = value;
                  },
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Selector<ModifyUserinfoModel, bool>(
                  selector: (context, model)=>model.commitButtonEnable,
                  shouldRebuild: (pre, next)=>pre!=next,
                  builder: (context, value, child) {
                    return FlatButton(
                      onPressed: value ? confirmButtonPressed : null,
                      child: child,
                      color: Colors.green[600],
                      disabledColor: Colors.grey[400],
                    );
                  },
                  child: Text(
                    '修改',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]
      ),
    );
  }
}
