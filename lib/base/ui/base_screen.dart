import 'package:flutter/material.dart';
import 'package:rapidparty/base/presenter/base_presenter.dart';
import 'package:rapidparty/base/ui/base_listener.dart';
import 'package:rapidparty/utils/prefs.dart';

abstract class BaseScreen extends StatefulWidget {
  final BaseListener listener;
  final String title;
  BaseScreen(this.title, this.listener, {Key key}) : super(key: key);
}

abstract class BaseScreenState<T extends BaseScreen, P extends BasePresenter>
    extends State<T> with TickerProviderStateMixin implements BaseContract {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  Prefs prefs;
  double screenHeight;
  double screenWidth;

  Color primaryColor;
  // AppBar appBar;

  TextTheme textTheme;

  //Presenter
  P presenter;

  final actions = <Widget>[];

  P createPresenter();

//AnimatedButtonController
  AnimationController animationController;

  BaseScreenState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    presenter = createPresenter();
  }

  void showSnackBar(String message) {
    if (message == null) {
      //message = "Some Error Occur";
      return;
    }
    // print("SNACK MSG $message");
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 1),
    ));
  }

  Widget buildBody(BuildContext context);

  bool isIOS() {
    return Theme.of(context).platform == TargetPlatform.iOS;
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    primaryColor = Theme.of(context).primaryColor;
    textTheme = Theme.of(context).textTheme;
    return Scaffold(
      key: scaffoldKey,
      appBar: getAppBar(),
      body: buildBody(context),
    );
  }

  @override
  void initState() {
    super.initState();
    initSharedPrefs();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => onBuildComplete(context));
  }

  void hideKeyboard() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  AppBar getAppBar() {
    return widget.title == null
        ? null
        : AppBar(
            title: Text(
              widget.title != null ? widget.title : "",
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
            leading: Material(
              color: primaryColor,
              child: InkWell(
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  Navigator.of(context).pop();
                },
                splashColor: primaryColor,
              ),
            ),
            backgroundColor: primaryColor,
            centerTitle: true,
            elevation: 0.0,
            actions: actions,
          );
    //return appBar;
  }

  @override
  void showMessage(String message) {
    showSnackBar(message);
  }

  @override
  void onError(String messageError) {
    showSnackBar(messageError);
  }

  @override
  void dispose() {
    presenter.dispose();
    super.dispose();
  }

  void onBuildComplete(BuildContext context) {}

  void initSharedPrefs() {
    this.prefs = widget.listener.getPrefs();
  }
}
