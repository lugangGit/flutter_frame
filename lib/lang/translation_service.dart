import 'package:flutter/material.dart';
import 'package:flutter_frame/common/user/user_record_manager.dart';
import 'package:get/get.dart';
import 'translations/en_US.dart';
import 'translations/zh_CN.dart';

class TranslationService extends Translations {
  static Locale? get locale => Get.deviceLocale;
  static const fallbackLocale = Locale('zh', 'CN');

  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('zh', 'CN'),
  ];

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': en_US,
    'zh_CN': zh_CN
  };
}
