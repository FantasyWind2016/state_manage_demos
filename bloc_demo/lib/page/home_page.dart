import 'package:bloc_demo/bloc/account_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../page/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('home'),
        ),
        body: _HomePageBody(),
      ),
    );
  }
}

class _HomePageBody extends StatefulWidget {
  _HomePageBody({Key key}) : super(key: key);

  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<_HomePageBody> {

  void unloginButtonPressed() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return LoginPage();
    }));
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
                    Icon(Icons.account_circle),
                    Text(state.userName ?? ''),
                  ],
                )),
          ]),
        );
      },
    );
  }
}
