import 'dart:convert';
import 'dart:io';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

// 本地存储
class StorageManager {
  /// app全局配置 eg:theme todo late 可考虑使用可空 更安全
  static late SharedPreferences sharedPreferences;

  /// 临时目录(Android 应用内cache、iOS 沙盒)
  static late Directory temporaryDirectory;

  ///Android 应用下file
  static late Directory _externalStorageDirectory;

  /// 外部存储目录（临时目录(Android 应用下file 、iOS 沙盒)）
  static Directory get externalStorageDirectory {
    if (Platform.isAndroid) return _externalStorageDirectory;
    return temporaryDirectory;
  }

  // ///splash缓存文件夹
  // static String get splashCacheFolder => temporaryDirectory.path + "/splash";
  //
  // ///lottie缓存文件夹
  // static String get lottieCacheFolder => temporaryDirectory.path + "/lottie";
  //
  // static String get newsPaperCacheFolder => temporaryDirectory.path + "/newspaper";
  //
  // ///音频文件
  // static String get audioCacheFolder => _getAudioPath();

  /// 初始化必备操作 eg:user数据
  static late LocalStorage localStorage;

  static initSP() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  /// 必备数据的初始化操作
  ///
  /// 由于是同步操作会导致阻塞,所以应尽量减少存储容量
  static init({String localStorageKey = 'localStorage'}) async {
    // async 异步操作
    // sync 同步操作
    temporaryDirectory = await getTemporaryDirectory();
    sharedPreferences = await SharedPreferences.getInstance();
    if (Platform.isAndroid) {
      var d = await getExternalStorageDirectory();
      if (null != d) {
        _externalStorageDirectory = d;
      }
    }
    try {
      // var localStorageKey = sharedPreferences.getString(SharedPreferenceKey.localStorage) ?? "localStorage";
      localStorage = LocalStorage(localStorageKey);
    } catch (e) {
      // LogUtil.e('初始化失败');
      // LogUtil.e(e);
    }

    if (localStorage == null) {
      // LogUtil.e('初始化失败');
    }
    await localStorage.ready;
    // await UserRecordManager.init();
  }

  //私有构造函数
  StorageManager._internal();

  //保存单例
  static StorageManager _singleton = new StorageManager._internal();

  //工厂构造函数
  factory StorageManager() => _singleton;

}
