import 'package:bloc_demo/bloc/account_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../login/login_page.dart';
import '../modify_userinfo/modify_userinfo_page.dart';
import 'bloc/my_bloc.dart';

class MyPage extends StatelessWidget {
  final String title;
  const MyPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(this.title),
        ),
        body: BlocProvider<MyBloc>(
          create: (context) => MyBloc(),
          child: _MyPageBody(),
        ),
      ),
    );
  }
}

class _MyPageBody extends StatefulWidget {
  _MyPageBody({Key key}) : super(key: key);

  @override
  _MyPageBodyState createState() => _MyPageBodyState();
}

class _MyPageBodyState extends State<_MyPageBody> {
  void unloginButtonPressed() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return LoginPage();
    }));
  }

  void modifyNameButtonPressed() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return ModifyUserInfoPage();
    }));
  }

  void logoutButtonPressed() {
    BlocProvider.of<AccountBloc>(context).add(AccountClear());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountInitial>(
      builder: (context, state) {
        return Container(
          child: Column(children: [
            Visibility(
              visible: state.unlogin,
              child: FlatButton(
                  onPressed: unloginButtonPressed, child: Text('用户未登录')),
            ),
            Visibility(
                visible: !state.unlogin,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.account_circle,
                      size: 44,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(state.userName ?? ''),
                        Text(state.userModel?.name ?? ''),
                      ],
                    ),
                  ],
                )),
            Visibility(
              visible: !state.unlogin,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      onPressed: modifyNameButtonPressed,
                      child: BlocBuilder<MyBloc, MyState>(
                        builder: (context, state) {
                          return Text(
                            state.modifySuccess ? '修改姓名成功' : '修改姓名',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                      color: Colors.blue[100],
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: !state.unlogin,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      onPressed: logoutButtonPressed,
                      child: Text(
                        '退出登录',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ]),
        );
      },
    );
  }
}
