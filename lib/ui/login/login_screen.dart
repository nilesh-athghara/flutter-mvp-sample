import 'package:flutter/material.dart';
import 'package:rapidparty/base/ui/base_screen.dart';
import 'package:rapidparty/ui/login/login_presenter.dart';

class LoginScreen extends BaseScreen {
  LoginScreen(String title, listener) : super(title, listener);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseScreenState<LoginScreen, LoginPresenter> {
  @override
  Widget buildBody(BuildContext context) {
    return Container();
  }

  @override
  LoginPresenter createPresenter() {
    return LoginPresenter(this);
  }
}
