import 'package:bloc_demo/bloc/modify_userinfo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/account_model.dart';
import '../model/user_model.dart';
import '../utils/account_manager.dart';

class ModifyUserInfoPage extends StatelessWidget {

  ModifyUserInfoPage({Key key}) : super(key: key);

  final ModifyUserinfoBloc bloc = ModifyUserinfoBloc();

  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    nameController.text = bloc.state.name;
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Modify Name'),
        ),
        body: BlocProvider(
          create: (_) => bloc,
          child:_modifyUserInfoPageBody(context),
        ),
      ),
    );
  }

  void confirmButtonPressed() {
    bloc.add(CommitButtonClick());
  }
  
  Widget _modifyUserInfoPageBody(BuildContext context) {
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
                    bloc.add(NameChanged(name: value));
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
