import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../model/account_model.dart';
import 'modify_userinfo_state.dart';

class ModifyUserInfoPage extends StatelessWidget {
  const ModifyUserInfoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accountStore = StoreProvider.of<AccountModel>(context, listen: false);
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Modify Name'),
        ),
        body: StoreProvider(
          store: Store<ModifyUserinfoState>(modifyUserinfoReducer, initialState: ModifyUserinfoState(initialName: accountStore.state.userModel?.name)),
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
  Store<ModifyUserinfoState> store;
  void confirmButtonPressed() {
    store.dispatch(Commit(StoreProvider.of<AccountModel>(context, listen: false)));
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
    nameController.text = store.state.initialName;
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
