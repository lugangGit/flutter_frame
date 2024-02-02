import 'utils.dart';

class AppModel {
  static String baseUrl() {
    Map? appConfig = StorageManager.localStorage.getItem(AppLocalStorageKey.app);
    if (appConfig != null) {
      return (appConfig['baseUrl'] ?? "").toString().isNotEmpty ? appConfig['baseUrl'] : Api.baseUrl;
    }else {
      return Api.baseUrl;
    }
  }

  static Future initApp() async {

    ///初始化缓存管理
    try {
      await StorageManager.init();
    } catch (error) {
      StorageManager.localStorage.clear();
      await StorageManager.init();
    }

    /// 初始化request类
    Http.init(
      baseUrl: Constant.isRelease ? Api.baseUrl : baseUrl(),
    );

    ///是否开启日志
    LogUtil.init(isDebug: !Constant.isRelease, tag: "App");
  }

}