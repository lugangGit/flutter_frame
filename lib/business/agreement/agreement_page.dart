import 'dart:io';
import 'package:flutter/Material.dart';
import 'package:flutter_frame/common/widgets/agreement_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter_frame/utils.dart';

///隐私授权页面
class AgreementPage extends StatefulWidget {
  const AgreementPage({Key? key}) : super(key: key);

  @override
  State<AgreementPage> createState() => _AgreementPageState();
}

class _AgreementPageState extends State<AgreementPage> {

  @override
  Widget build(BuildContext context) {
    return AgreementDialog(
      onDialogCloseWithAgree: (agree) {
        if (agree) {
          _onTapAgreeAgreement();
        } else {
          exitApp();
        }
      },
    );
  }

  void _onTapAgreeAgreement() async {
    StorageManager.sharedPreferences.setBool(SharedPreferenceKey.agreedPrivacy, true);
    // AppSdkManager.initSdks();
    Get.offNamed('/?id=123', preventDuplicates: false);
  }

  void exitApp() {
    //todo 暴力退出app,可优化
    exit(0);
  }
}
