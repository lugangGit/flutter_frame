import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frame/utils.dart';
import 'package:get/get.dart';

showAgreementDialog(BuildContext context,
    {String? title, String? tips, String? subTips, String? cancel, String? ok, bool? transparent, ValueChanged<bool>? onDialogCloseWithAgree}) {
  final child = WillPopScope(
    onWillPop: () {
      return Future.value(false);
    },
    child: AgreementDialog(onDialogCloseWithAgree: onDialogCloseWithAgree, title: title, tips: tips, subTips: subTips, cancel: cancel, ok: ok, transparent: transparent),
  );

  showGeneralDialog(
      barrierColor: transparent == true ? Colors.transparent : Colors.black38,
      barrierDismissible: false,
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return child;
      },
      transitionDuration: const Duration(milliseconds: 0),
      transitionBuilder: (ctx, animation, _, child) {
        return FractionalTranslation(
          translation: const Offset(0, 0),
          child: child,
        );
      });
}

/// 隐私协议弹窗
class AgreementDialog extends StatelessWidget {
  final ValueChanged<bool>? onDialogCloseWithAgree;
  final String? title;
  final String? tips;
  final String? subTips;
  final String? cancel;
  final String? ok;
  final bool? transparent;

  const AgreementDialog({this.onDialogCloseWithAgree, this.title, this.tips, this.subTips, this.cancel, this.ok, this.transparent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: transparent == true ? Colors.black54 : null,
      body: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Container(
          color: transparent == true ? Colors.transparent : Colors.black54,
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              padding: const EdgeInsets.only(top: 25),
              child: GestureDetector(
                child: Text('confirm'.tr,),
                onTap: (){
                  onDialogCloseWithAgree?.call(true);
                },
              ),
              // decoration: BoxDecoration(
              //   color: AppColor.background.of(context),
              //   borderRadius: BorderRadius.all(Radius.circular(10.0.adaptFromWidth)),
              // ),
              // child: Column(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   mainAxisSize: MainAxisSize.min,
              //   children: <Widget>[
              //     Text(
              //       title ?? "个人信息保护指引",
              //       style: AppTextStyle.titleLarge.copyWith(color: AppColor.text2, letterSpacing: 1.5, fontWeight: FontWeight.w600).of(context),
              //     ),
              //     const SizedBox(height: 15),
              //     Container(
              //       padding: const EdgeInsets.symmetric(horizontal: 10),
              //       child: FZFlex(
              //         mainAxisSize: MainAxisSize.min,
              //         direction: Axis.vertical,
              //         spacing: 15,
              //         children: <Widget>[
              //           Text(
              //             tips ?? "为了更好的维护您的利益，我们对《用户服务协议及隐私政策》进行了更新，特向您推送本提示。请仔细阅读并充分理解相关条款。",
              //             style: AppTextStyle.titleSmall.copyWith(color: AppColor.text2, letterSpacing: 1, height: 1.5).of(context),
              //           ),
              //           Text(
              //             subTips ?? "您点击“同意”，即表示您已阅读并同意更新后的 《用户服务协议及隐私政策》",
              //             style: AppTextStyle.titleSmall.copyWith(color: AppColor.text2, letterSpacing: 1, height: 1.5).of(context),
              //           ),
              //           RichText(
              //             text: TextSpan(children: <TextSpan>[
              //               TextSpan(
              //                 text: "查看完整版",
              //                 style: AppTextStyle.labelLarge
              //                     .copyWith(
              //                       fontSize: 14,
              //                       letterSpacing: 1,
              //                     )
              //                     .of(context),
              //               ),
              //               TextSpan(
              //                   text: "《用户协议》",
              //                   style: AppTextStyle.labelLarge
              //                       .copyWith(
              //                         fontSize: 14,
              //                         color: AppColor.primary,
              //                         letterSpacing: 1,
              //                       )
              //                       .of(context),
              //                   recognizer: TapGestureRecognizer()
              //                     ..onTap = () {
              //                       pushUserAgreement();
              //                     }),
              //               TextSpan(
              //                 text: "和",
              //                 style: AppTextStyle.labelLarge
              //                     .copyWith(
              //                       fontSize: 14,
              //                     )
              //                     .of(context),
              //               ),
              //               TextSpan(
              //                   text: "《隐私政策》",
              //                   style: AppTextStyle.labelLarge
              //                       .copyWith(
              //                         fontSize: 14,
              //                         color: AppColor.primary,
              //                         letterSpacing: 1,
              //                       )
              //                       .of(context),
              //                   recognizer: TapGestureRecognizer()
              //                     ..onTap = () {
              //                       pushPrivacyPolicy();
              //                     }),
              //             ]),
              //           )
              //         ],
              //       ),
              //     ),
              //     Container(
              //       margin: EdgeInsets.only(top: AppGap.xxLarge.value.adaptFromHeight),
              //       height: 0.5.adaptFromHeight,
              //       color: AppColor.border.of(context),
              //     ),
              //     Row(
              //       children: <Widget>[
              //         Expanded(
              //           child: InkWell(
              //             onTap: () {
              //               onDialogCloseWithAgree?.call(false);
              //             },
              //             child: Container(
              //               alignment: Alignment.center,
              //               height: 41.5.adaptFromHeight,
              //               child: Text(
              //                 cancel ?? "拒绝",
              //                 style: AppTextStyle.titleMedium.copyWith(color: AppColor.text4).of(context),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Container(
              //           width: 0.5.adaptFromWidth,
              //           height: 41.5.adaptFromHeight,
              //           color: AppColor.border.of(context),
              //         ),
              //         Expanded(
              //             child: InkWell(
              //           onTap: () {
              //             onDialogCloseWithAgree?.call(true);
              //           },
              //           child: Container(
              //             alignment: Alignment.center,
              //             height: 41.5.adaptFromHeight,
              //             child: Text(
              //               ok ?? "我同意",
              //               style: AppTextStyle.titleMedium.copyWith(color: AppColor.primary, fontWeight: FontWeight.bold).of(context),
              //             ),
              //           ),
              //         )),
              //       ],
              //     )
              //   ],
              // ),
            ),
          ),
        ),
      ),
    );
  }

  // 跳转到用户协议
  void pushUserAgreement() {
    // Get.to(() => const HYWebView(url: Api.User_Agreement, title: '用户协议'));
  }

  // 跳转到隐私政策
  void pushPrivacyPolicy() {
    // Get.to(() => const HYWebView(url: Api.Privacy_Policy, title: '隐私政策'));
  }
}
