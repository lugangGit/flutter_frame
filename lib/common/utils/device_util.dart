import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_frame/common/utils/sp_util.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceUtil {
  static bool get isDesktop => !isWeb && (isWindows || isLinux || isMacOS);
  static bool get isMobile => isAndroid || isIOS;
  static bool get isWeb => kIsWeb;

  static bool get isWindows => !isWeb && Platform.isWindows;
  static bool get isLinux => !isWeb && Platform.isLinux;
  static bool get isMacOS => !isWeb && Platform.isMacOS;
  static bool get isAndroid => !isWeb && Platform.isAndroid;
  static bool get isFuchsia => !isWeb && Platform.isFuchsia;
  static bool get isIOS => !isWeb && Platform.isIOS;

  static Future<String> appVersion() async {
    if (kIsWeb) {
      return '';
    }
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  static Future<String> packageName() async {
    if (kIsWeb) {
      return '';
    }
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.packageName;
  }

  /// 获取App名称
  static Future<String> appName() async {
    if (kIsWeb) {
      return '';
    }
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.appName;
  }

  /// 获取packageInfo
  static Future<PackageInfo> packageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo;
  }

  ///设备ID Android 使用androidId,iOS 使用identifierForVendor
  static Future<String> deviceId() async {
    if (kIsWeb) {
      return '';
    }
    String? deviceId = SpUtil.getString("deviceId", defValue: '');
    if ('' != deviceId) {
      return Future.value(deviceId);
    }
    deviceId = await FlutterUdid.udid;
    SpUtil.putString("deviceId", deviceId);
    return deviceId;
  }

  static AndroidDeviceInfo? _androidInfo;

  ///全局的androidInfo信息
  static Future<AndroidDeviceInfo?> get androidInfo async {
    if (Platform.isAndroid) {
      if (_androidInfo == null) {
        _androidInfo = await new DeviceInfoPlugin().androidInfo;
        return _androidInfo;
      } else {
        return Future.value(_androidInfo);
      }
    }
  }

  ///系统版本
  static Future<String> systemVersion() async {
    if (kIsWeb) {
      return '';
    }
    String version = "";
    DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();
    if (Platform.isAndroid) {
      version = (await androidInfo)?.version.release ?? "";
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      version = iosInfo.systemVersion.toString();
    }

    return version;
  }

  /// Android build version
  static Future<int> androidBuildVersion() async {
    if (Platform.isAndroid) {
      return (await androidInfo)?.version.sdkInt ?? 0;
    }
    return 0;
  }
}
