import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'modify_userinfo_state.dart';
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
        body: StoreProvider(
          store: Store<ModifyUserinfoState>(modifyUserinfoReducer, initialState: ModifyUserinfoState(initialName: AccountManager.instance.accountModel.userModel?.name)),
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
  Store store;
  void confirmButtonPressed() {
    store.dispatch(Commit());
  }

  var nameController = TextEditingController();
  @override
  void initState() {
    store = StoreProvider.of<ModifyUserinfoState>(context, listen: false);
    store.onChange.listen((onData){
      if (onData is ModifyUserinfoState) {
        if (onData.commitSuccess) {
          Navigator.of(context).pop();
        }
      }
    });
    nameController.text = AccountManager.instance.accountModel.userModel?.name;
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
                onChanged: (value){
                  store.dispatch(NameUpdate(value));
                },
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: StoreConnector<ModifyUserinfoState, bool>(
                converter: (store)=>store.state.commitButtonEnable,
                builder:(context, value) => FlatButton(
                  onPressed: value ? confirmButtonPressed : null,
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
