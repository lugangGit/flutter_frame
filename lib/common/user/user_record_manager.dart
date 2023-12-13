import 'package:flutter/Material.dart';

import '../../utils.dart';

class UserRecordManager {

  ///0跟随系统 1浅色模式 2深色模式
  static setThemeMode(int themeMode, {bool update = true}) {
    StorageManager.sharedPreferences.setInt(SharedPreferenceKey.nightMode, themeMode);
    if(update) {
      Get.changeThemeMode(ThemeMode.values[themeMode]);
    }
  }

  static ThemeMode getThemeMode() {
    final index = StorageManager.sharedPreferences.getInt(SharedPreferenceKey.nightMode) ?? 0;
    return ThemeMode.values[index];
  }

  ///设置语言
  static setLocale(String languageCode, String countryCode, {bool update = true}) {
    StorageManager.sharedPreferences.setStringList(SharedPreferenceKey.locale, [languageCode, countryCode]);
    if(update) {
      var l = Locale(languageCode, countryCode);
      Get.updateLocale(l);
    }
  }

  static Locale? getLocale() {
    final locales = StorageManager.sharedPreferences.getStringList(SharedPreferenceKey.locale) ?? [];
    if (locales.length == 2) {
      var l = Locale(locales.first, locales.last);
      return l;
    }
    return Get.deviceLocale;
  }
}