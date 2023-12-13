import 'package:flutter/material.dart';

extension ColorExt on Color{
  Color get grey => _grey();
  String get radixString => _getRadixString();
  Color _grey(){
   int red = (this.red * 0.299).toInt();
   int green = (this.green * 0.587).toInt();
   int blue = (this.blue * 0.114).toInt();
   int gray = red + green + blue;
   return Color.fromARGB(this.alpha, gray, gray, gray);
 }

 static Color fromHex(String hexColor){
   try {
     hexColor = hexColor.toUpperCase().replaceAll("#", "");
     if (hexColor.length == 6) {
       hexColor = "FF" + hexColor;
     }
     return  Color(int.parse(hexColor, radix: 16));
   } catch (e) {
     return Color(int.parse('FFFFFFFF', radix: 16));
   }
 }

 String _getRadixString(){
    return value.toRadixString(16).padLeft(8, '0');
 }

}

///十六进制颜色
class HexColor extends Color {
  static int _getColorFromHex(String hexColor, {dynamic defaultColor}) {
    try {
      hexColor = hexColor.toUpperCase().replaceAll("#", "");
      if (hexColor.length == 6) {
        hexColor = "FF" + hexColor;
      }
      return int.parse(hexColor, radix: 16);
    } catch (e) {
      if (null != defaultColor) {
        if (defaultColor is Color) {
          return defaultColor.value;
        }
        if (defaultColor is String) {
          return _getColorFromHex(defaultColor);
        }
      }
      return int.parse("00FFFFFF", radix: 16);
    }
  }

  /// hexColor      ：待转换的颜色字符串 "#FFF000"
  /// defaultColor  ：默认颜色， 转换异常之后会返回该值，可传 Color 或颜色字符串，不传默认返回透明色
  HexColor(final String hexColor, {dynamic defaultColor}) : super(_getColorFromHex(hexColor, defaultColor: defaultColor));

}
