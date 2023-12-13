import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'color_ext.dart';

/// Toast 工具类
class ToastUtil {
  /// 展示toast
  /// [msg] 消息
  /// [gravity] 位置，默认下方
  /// [toastLength] 提示时长，默认短
  /// [timeInSecForIos] iOS 提示时长,默认1秒
  static void show(
      {required String msg,
        ToastGravity gravity = ToastGravity.CENTER,
        Toast toastLength = Toast.LENGTH_SHORT,
        int timeInSecForIosWeb = 1,
        Color? backgroundColor,
        Color? textColor}) {
    try {
      Fluttertoast.cancel();
    } catch (e) {}
    Fluttertoast.showToast(
        msg: msg,
        toastLength: toastLength,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor ?? HexColor("#90000000"),
        textColor: textColor ?? HexColor("#ffffff"),
        fontSize: 16.0,
        webPosition: "center",
        webBgColor: "linear-gradient(to right, #FF0000, #FF0000)",
    );
  }
}
