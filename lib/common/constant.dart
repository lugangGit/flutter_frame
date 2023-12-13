import 'dart:ui';

import 'package:flutter/foundation.dart';

class Constant {

  ///appStore id
  static String  iosAppId = "id1485873713";

  /// App运行在Release环境时，inProduction为true；当App运行在Debug和Profile环境时，inProduction为false
  static const bool inProduction = kReleaseMode;

  static bool isDriverTest  = false;
  static bool isUnitTest  = false;

  static const String data = 'data';
  static const String message = 'message';
  static const String code = 'code';
  static const int success = 1;

  static const String userId = 'userId';
  static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';
  static const String showLogin = 'showLogin';
  static const String showGuide = 'showGuide';

  static const String locale = 'locale';

  //应用平台
  static const int platformApple = 100;
  static const int platformAndroid = 200;

  //渠道号
  static const int channelOfficial = 100;
  static const int channelAppleStore = 200;
}


///App中的图片资源列表
class ImageName {
  ///引导页
  static const String guide1 = "assets/images/guide1.jpg";
  static const String guide2 = "assets/images/guide2.jpg";
  static const String guide3 = "assets/images/guide3.jpg";
  static const String guideButton = "assets/images/guide_button.png";

  ///启动页
  static const String splashLogo = "assets/images/splash_logo.png";

  ///底部bar
  static const String home = "assets/images/tabbar/home.svg";
  static const String mine = "assets/images/tabbar/mine.svg";
  static const String brand = "assets/images/tabbar/brand.svg";


  /// 主页底部Tab标签默认占位图 - 首页
  static const String navBack = "assets/images/common/nav_back.svg";
}

class SharedPreferenceKey {
  static const String agreedPrivacy = "agreedPrivacy";
  static const String nightMode = "nightMode";
  static const String locale = "locale";

}

