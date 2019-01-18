import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rapidparty/base/ui/base_listener.dart';
import 'package:rapidparty/localization_app.dart';
import 'package:rapidparty/ui/login/login_screen.dart';
import 'package:rapidparty/utils/prefs.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget implements BaseListener {
  //router to route between screens
  final router = new Router();
  final prefs = Prefs();
  MyApp() {
    // router.define('/resetPassword/:data', handler: new Handler(
    //     handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    //   return ResetPasswordScreen(
    //     "Reset Password",
    //     this,
    //     data: params["data"][0],
    //   );
    // }));

    // router.define('/ForgotPassword', handler: new Handler(
    //     handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    //   return ForgotMobileScreen("Forgot Password", this);
    // }));

    // router.define('/skill/:data', handler: new Handler(
    //     handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    //   return AddSkillScreen(
    //       "${params["data"][0] != null && params["data"][0].isNotEmpty ? "Edit" : "Add"} Skill",
    //       this,
    //       data: params["data"][0]);
    // }));

    // router.define('/', handler: new Handler(
    //     handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    //   return SplashScreen(null, this);
    // }));

    router.define('/login', handler: new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return LoginScreen(null, this);
    }));
    initCrashService();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Reached',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primaryColor: Color.fromRGBO(48, 62, 151, 1.0),
        accentColor: Color.fromRGBO(0, 151, 224, 1.0),
        hintColor: Color.fromRGBO(0, 151, 224, 1.0),
      ),
      onGenerateRoute: router.generator,
      localizationsDelegates: [
        const LocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('he', 'IL'), // Hebrew
        // ... other locales the app supports
      ],
    );
  }

  @override
  Router getRouter() {
    return router;
  }

  @override
  Prefs getPrefs() {
    return prefs;
  }

  void initCrashService() async {
    // final ios = defaultTargetPlatform == TargetPlatform.iOS;
    // var app_secret = ios
    //     ? "5e35b558-27f1-485b-aad8-970d91e987b5"
    //     : "597b1265-b108-45ce-9757-da08852431b1";

    // await AppCenter.start(app_secret, [AppCenterCrashes.id]);
    // await AppCenterCrashes.setEnabled(true);
  }
}
