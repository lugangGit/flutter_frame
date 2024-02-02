import 'package:flutter/cupertino.dart';

class GlobalKeyManager {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> tabNavigationKey = GlobalKey<NavigatorState>();

  ///导航上下文，可在无BuildContext的地方，方便打开页面
  ///todo 非可空更好用，可！优化
  static BuildContext? navigatorContext(){
    return navigatorKey.currentContext;
  }

  static BuildContext? get context => _getContext();
  static BuildContext? _getContext(){
    return tabNavigationKey.currentContext;
  }

}