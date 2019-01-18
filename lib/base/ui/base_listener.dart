import 'package:fluro/fluro.dart';
import 'package:rapidparty/utils/prefs.dart';

abstract class BaseListener {
  Router getRouter();
  Prefs getPrefs();
}
