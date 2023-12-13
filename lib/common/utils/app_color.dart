import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_frame/common/utils/string_ext.dart';
import 'color_ext.dart';

class AppColor {
  final Color light;
  final Color? dark;

  const AppColor({required this.light, this.dark});

  ///灰色矩阵
  static const List<double> greyMatrix = [
    0.213, 0.715,0.072,0,0,
    0.213, 0.715,0.072,0,0,
    0.213, 0.715,0.072,0,0,
    0,0,0,1,0,
  ];

  dynamic get rawValue => _getRawValue();

  static Map<String, AppColor> get colors => {
        "primary": primary,
        "primary8": primary8,
        "primary50": primary50,
        "secondary": secondary,
        "tertiary": tertiary,
        "background": background,
        "canvas": canvas,
        "border": border,
        "disable": disable,
        "divider": divider,
        "highlight": highlight,
        "sub": sub,
        "warning": warning,
        "hint": hint,
        "placeholder": placeholder,
        "text1": text1,
        "text2": text2,
        "text3": text3,
        "text4": text4,
        "card": card,
        "icon": icon,
        "black50": black50,
        "shadow": shadow
      };

  dynamic _getRawValue() {
    String key = colors.keys.firstWhere((k) => colors[k] == this, orElse: () => '');
    return key.isNotEmpty ? key : {"light": light.radixString, "dark": dark?.radixString};
  }

  static AppColor? from(dynamic value) {
    if (value == null) {
      return null;
    }
    if (value is String) {
      return AppColor.getColorWithType(value);
    } else if (value is Map) {
      return AppColor.fromJson(value);
    }
    return null;
  }

  static AppColor?  fromJson(Map<dynamic, dynamic>? json) {
    if (json == null) {
      return null;
    }
    return AppColor(
      light: HexColor(json["light"]),
      dark: HexColor(json["dark"]),
    );
  }

  ///默认color为light颜色
  Color get value =>  light;

  Color get lightValue => light;

  Color get darValue =>  dark ?? light;

  static getColorWithType(String? value) {
    if (value == null) return AppColor.defaultColor;
    return colors['$value'] ??
        (colors['${value.replaceAll(RegExp('[^a-zA-Z]'), '')}'] != null
            ? AppColor(//value.number?.alpha
                light: colors['${value.replaceAll(RegExp('[^a-zA-Z]'), '')}']!.light.withAlpha((min(value.number ?? 255,100)/100*255).ceil()),
                dark: colors['${value.replaceAll(RegExp('[^a-zA-Z]'), '')}']!.dark?.withAlpha((min(value.number ?? 255,100)/100*255).ceil()))
            : AppColor(light: HexColor(value), dark: HexColor(value)));
  }

  static Brightness brightness(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return themeData.brightness;
  }

  Color of(BuildContext context) {
    // Color color = brightness(context) == Brightness.light ? lightValue : darValue;
    final ThemeData themeData = Theme.of(context);
    Color color = themeData.brightness == Brightness.light ? lightValue : darValue;
    return color;
  }

  ///主题色,导航栏背景、按钮的背景
  static var primary = AppColor(light: HexColor('#E32416'), dark: HexColor('#cccccc'));

  ///8%透明度主题色:标签背景
  static AppColor get  primary8 => AppColor(light: primary.light.withAlpha(20), dark: primary.dark?.withAlpha(20));

  ///50%透明度主题色：标签背景
  static AppColor get  primary50 => AppColor(light: primary.light.withAlpha(128), dark: primary.dark?.withAlpha(128));

  ///二级题色,直播、活动稿件状态
  static var secondary = AppColor(light: HexColor('#1287f3'), dark: HexColor('#1287f3'));

  ///三级题色，特殊警告背景色
  static var tertiary = AppColor(light: HexColor('#fbe86e'), dark: HexColor('#000000'));

  ///页面背景色，脚手架背景色
  static var background = AppColor(light: HexColor('#FFFFFF'), dark: HexColor('1d1d1e'));

  ///Material组件的背景色,如文本框背景色
  static var canvas = AppColor(light: HexColor('#F6F6F6'), dark: HexColor('#2b2b2d'));

  ///边框颜色
  static var border = AppColor(light: HexColor('#dddddd'), dark: HexColor('#2c2c2e'));

  ///分割线
  static var divider = AppColor(light: HexColor('#efefef'), dark: HexColor('#3b3b3c'));

  ///不可用状态颜色
  static var disable = AppColor(light: HexColor('#d3d3d3'), dark: HexColor('#dddddd'));

  ///文字高亮颜色
  static var highlight = AppColor(light: primary.light, dark: primary.dark);

  ///一级文字颜色：导航栏标题、新闻列表标题、详情页标题和正文
  static var text1 = AppColor(light: HexColor('#000000'), dark: HexColor('#ffffff'));

  ///二级文字颜色：摘要、部分按钮、详细介绍文字
  static var text2 = AppColor(light: HexColor('#333333'), dark: HexColor('#ffffff'));

  ///三级文字颜色：摘要、部分按钮、详细介绍文字
  static var text3 = AppColor(light: HexColor('#666666'), dark: HexColor('#888888'));

  ///四级文字颜色：时间显示、副标题、未点赞文字
  static var text4 = AppColor(light: HexColor('#999999'), dark: HexColor('#aaaaaa'));

  ///辅助色：轮播图、标签、组图详情
  static var sub = AppColor(light: HexColor('#ffffff'), dark: HexColor('#ffffff'));

  ///特殊警告背景色：浮窗消息背景
  static var warning = AppColor(light: HexColor('#2e74ee'), dark: HexColor('#2051ab'));

  static var hint = AppColor(light: HexColor('#CCCCCC'), dark: HexColor('#CCCCCC'));

  ///卡片的背景色
  static var card = AppColor(light: HexColor('#ffffff'), dark: HexColor('#3b3b3c'));

  ///图标的默认颜色
  static var icon = AppColor(light: HexColor('#333333'), dark: HexColor('#dddddd'));

  ///封面图背景色
  static var placeholder = AppColor(light: HexColor('#ececec'), dark: HexColor('#ececec'));

  ///阴影颜色
  static var shadow = AppColor(light: HexColor('#10353535'), dark: HexColor('2C2C2E'));

  ///50%黑色:标签背景
  static var black50 = AppColor(light: Color(0x80000000), dark: Color(0x80000000));

  static AppColor defaultColor = AppColor(light: Colors.white, dark: Colors.black);

  static init(Map? json) {
    primary = AppColor.fromJson(json?["primary"]) ?? AppColor.primary;
    secondary = AppColor.fromJson(json?["secondary"]) ?? AppColor.secondary;
    tertiary = AppColor.fromJson(json?["tertiary"]) ?? AppColor.tertiary;
    background = AppColor.fromJson(json?["background"]) ?? AppColor.background;
    disable = AppColor.fromJson(json?["disable"]) ?? AppColor.disable;
    highlight = AppColor.fromJson(json?["highlight"]) ?? AppColor.highlight;
    canvas = AppColor.fromJson(json?["canvas"]) ?? AppColor.canvas;
    border = AppColor.fromJson(json?["border"]) ?? AppColor.border;
    placeholder = AppColor.fromJson(json?["placeholder"]) ?? AppColor.placeholder;
    divider = AppColor.fromJson(json?["divider"]) ?? AppColor.divider;
    text1 = AppColor.fromJson(json?["text1"]) ?? AppColor.text1;
    text2 = AppColor.fromJson(json?["text2"]) ?? AppColor.text2;
    text3 = AppColor.fromJson(json?["text3"]) ?? AppColor.text3;
    text4 = AppColor.fromJson(json?["text4"]) ?? AppColor.text4;
    sub = AppColor.fromJson(json?["sub"]) ?? AppColor.sub;
    warning = AppColor.fromJson(json?["warning"]) ?? AppColor.warning;
    hint = AppColor.fromJson(json?["hint"]) ?? AppColor.hint;
    card = AppColor.fromJson(json?["card"]) ?? AppColor.card;
    icon = AppColor.fromJson(json?["icon"]) ?? AppColor.icon;
    shadow = AppColor.fromJson(json?["shadow"]) ?? AppColor.shadow;
  }
}
