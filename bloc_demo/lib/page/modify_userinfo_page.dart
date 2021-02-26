import 'package:bloc_demo/bloc/modify_userinfo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/account_model.dart';
import '../model/user_model.dart';
import '../utils/account_manager.dart';

class ModifyUserInfoPage extends StatelessWidget {
  const ModifyUserInfoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Modify Name'),
        ),
        body: BlocProvider(
          create: (_) => ModifyUserinfoBloc(),
          child: _ModifyUserInfoPageBody(),          
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
    BlocProvider.of<ModifyUserinfoBloc>(context).add(CommitButtonClick());
  }

  var nameController = TextEditingController();
  
  @override
  void initState() {
    // todo 如何单独取state?可以在build里获取bloc初始化，但会执行多次
    nameController.text = ModifyUserinfoBloc().state.name;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ModifyUserinfoBloc, ModifyUserinfoInitial>(
      listener: (context, state){
        if (state.commitSuccess) {
          AccountModel accountModel = AccountManager.instance.accountModel;
          accountModel.userModel = UserModel();
          accountModel.userModel.name = nameController.text;
          AccountManager.instance.saveInfo(accountModel);

          Navigator.of(context).pop();
        }
      },
      builder:(context, state) {
        return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            children: <Widget>[
              Text('姓名：'),
              Expanded(
                child: TextField(
                  controller: nameController,
                  onChanged: (value){
                    context.bloc<ModifyUserinfoBloc>().add(NameChanged(name: value));
                  },
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  onPressed: state.commitButtonEnabled ? confirmButtonPressed : null,
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
        ]);
      } 
    );
  }
}
