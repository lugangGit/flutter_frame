import '../../utils.dart';

///管理各种第三方SDK
class AppSdkManager {
  ///初始化各种第三方SDK， 用户不同意隐私协议之前不初始化，同意之后再初始化
  static initSdks() {
    if (StorageManager.sharedPreferences.getBool("agreedPrivacy") != true) {
      return;
    }
    //_initShareSDk();
    _initFluwx();
    _initIMPlugin();
  }

  /// 初始化网易云信SDK
  static void _initIMPlugin() {
    // ChatKitClient.init();
  }

/*
/// shareSDK 初始化
void _initShareSDk() {
  // 1.同意shareSDK隐私协议
  SharesdkPlugin.uploadPrivacyPermissionStatus(1, (bool success) {
    print("ShareSDK 同步隐私协议 + 同意，ShareSDK 返回 ${success ? "成功" : "失败"}");
  });
  //2.初始化iOS sdk
  if (Platform.isIOS) {
    ShareSDKRegister register = ShareSDKRegister();
    // todo 完善iOS 微信分享参数，还有plist文件里
    register.setupWechat("wxaf368ee1e9235ebd", "", "https://service.ddcat.shop/app/share/");
    SharesdkPlugin.activePlatforms();
  }
}*/

  static void _initFluwx() {
    // 微信注册
    // Fluwx fluwx = Fluwx();
    // fluwx.registerApi(appId: "wxaf368ee1e9235ebd", universalLink: "https://service.ddcat.shop/app/share/");
  }
}
