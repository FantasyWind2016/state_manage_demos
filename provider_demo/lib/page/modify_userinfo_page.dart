import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/model/account_model.dart';
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
          create: (_)=>ModifyUserinfoModel(initialName: Provider.of<AccountModel>(context, listen: false).userModel?.name),
          child: _ModifyUserInfoPageBody()
        ),
      ),
    );
  }
}

class _ModifyUserInfoPageBody extends StatelessWidget {
  _ModifyUserInfoPageBody({Key key}) : super(key: key);
  confirmButtonPressed() {
    Provider.of<ModifyUserinfoModel>(aContext, listen: false).commit(Provider.of<AccountModel>(aContext, listen: false));
  }

  final nameController = TextEditingController();
  // 交互方法需要context
  BuildContext aContext;
  @override
  Widget build(BuildContext context) {
    // 因为没有initState方法，所以需要一个只执行一次的方法
    AsyncMemoizer().runOnce((){
      nameController.text = Provider.of<ModifyUserinfoModel>(context, listen: false).initialName;
      aContext = context;
    });
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
