import 'package:flutter/Material.dart';
import '../constant.dart';
import 'app_color.dart';

class AppTextStyle{
  static TextStyle title(BuildContext context) {
    return TextStyle(
        color: AppColor.text2.of(context),
        fontSize: Dimens.font18,
        height: 1.2,
        fontWeight: FontWeight.bold);
  }

  static TextStyle subTitle(BuildContext context) {
    return TextStyle(
        color: AppColor.text2.of(context),
        fontSize: Dimens.font16,
        height: 1.2,
        fontWeight: FontWeight.normal);
  }
}