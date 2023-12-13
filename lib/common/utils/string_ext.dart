import 'dart:convert' as convert;
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

extension StringExt on String {

  /// 简化url赋值的判断条件
  /// final videoUrl = ""
  /// final videoUrl1= "https://********"
  /// 之前使用：final url = videoUrl.isUrl() ? videoUrl : (videoUrl1.isUrl()?videoUrl1:"https://****")
  /// 现在使用：final url = videoUrl.url ?? videoUrl1.url ?? "https://****"
  String? get url => (this.isUrl() ? this : null) ;

  bool isUrl() {
    return this.trimLeft().toLowerCase().startsWith("http") ||
        this.trimLeft().toLowerCase().startsWith("https") ||
        this.trimLeft().toLowerCase().startsWith("rtmp");
  }

  double toDouble({double defaultValue = 0}) {
    return double.tryParse(this) ?? defaultValue;
  }

  int toInt({int defaultValue = 0}) {
    return int.tryParse(this) ?? defaultValue;
  }

  bool toBool({bool defaultValue = false}) {
    return this == "true";
  }

  double aspectRatioValue() {
    List<String> values;
    if (this.contains("*")) {
      values = this.split('*');
    }else {
      values = this.split(':');
    }
    if (values.length == 2 && values.last.toDouble() != 0) {
      return values.first.toDouble() / values.last.toDouble();
    }
    if (values.length == 2 && values.first.toDouble() == 0){
      return 0;
    }
    return double.parse(this);
  }

  Size toSize() {
    if (this.isEmpty || this == "null") {
      return Size.zero;
    }
    final points = this.split(',');
    if (points.length == 2) {
      return Size(double.parse(points[0]), double.parse(points[1]));
    } else if (points.length == 1) {
      return Size(double.parse(points[0]), double.parse(points[0]));
    }
    return Size.zero;
  }

  Offset toOffset() {
    if (this.isEmpty || this == "null") {
      return Offset.zero;
    }
    final points = this.split(',');
    if (points.length == 2) {
      return Offset(double.parse(points[0]), double.parse(points[1]));
    } else if (points.length == 1) {
      return Offset(double.parse(points[0]), double.parse(points[0]));
    }
    return Offset.zero;
  }

  //Base64编码
  String base64Encode() {
    var content = convert.utf8.encode(this);
    var digest = convert.base64Encode(content);
    return digest;
  }

  //Base64解码
  String base64Decode() {
    List<int> bytes = convert.base64Decode(this);
    String result = convert.utf8.decode(bytes);
    return result;
  }

  FontWeight toFontWeight() {
    FontWeight fontWeight = FontWeight.normal;
    if (this == 'bold') {
      return FontWeight.bold;
    }
    return fontWeight;
  }

  FontStyle toFontStyle() {
    FontStyle fontStyle = FontStyle.normal;
    if (this == 'italic') {
      fontStyle =  FontStyle.italic;
    }
    return fontStyle;
  }

  ///格式化富文本内容
  ///将&nbsp；替换为" "
  String replaceEscapeCharacter() {
    if (this.isEmpty) {
      return this;
    }
    String parsedString = this;
    parsedString = parsedString.replaceAll("&nbsp;", " ");
    parsedString = parsedString.replaceAll(" ", " ");
    return parsedString;
  }

  Size textSize(TextStyle style,  {int maxLines = 2^31, double maxWidth = double.infinity}) {
    final TextPainter textPainter = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(text: this, style: style), maxLines: maxLines)
      ..layout(maxWidth: maxWidth);
    return textPainter.size;
  }

  BlendMode toBlendMode() {
    BlendMode mode = BlendMode.color;
    for(var element in BlendMode.values) {
      if (element.name == this) {
        mode = element;
        break;
      }
    }
    return mode;
  }

  String get word =>_getWord();
  String _getWord(){
    return this.replaceAll(RegExp('[^a-zA-Z]'), '');
  }

  int? get number =>_getNumber();
  int? _getNumber(){
    final number = this.replaceAll(RegExp('[^0-9]'), '');
    if(number.length > 0){
      return int.tryParse(number);
    }
    return null;
  }

  TextDirection toTextDirection() {
    TextDirection textDirection = TextDirection.ltr;
    if (this == 'rtl') {
      textDirection =  TextDirection.rtl;
    }
    return textDirection;
  }

  ///判断文本中包含html标签
  bool get isHtmlText => RegExp(r"<\/?([a-zA-Z][a-zA-Z0-9]*)\b[^>]*>").hasMatch(this);



}
