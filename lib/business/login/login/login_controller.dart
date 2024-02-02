import 'dart:ffi';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_frame/common/entity/user.dart';
import 'package:get/get.dart';
import '../../../utils.dart';
import 'login_state.dart';

class LoginController extends GetxController {
  final LoginState state = LoginState();
  TextEditingController usernameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  UserModel? userModel;

  @override
  void onInit() {
    super.onInit();
    var arguments = Get.arguments;

    Get.printInfo(info: 'home: onInit');
  }

  @override
  void onReady() {
    super.onReady();
    Get.printInfo(info: 'home: onReady');
  }

  @override
  void onClose() {
    Get.printInfo(info: 'home: onClose');
    super.onClose();
  }

  Future<bool> login(String phone, String password) async {
    LogUtil.v(phone + password);
    String cur = Get.currentRoute;
    User user = User(
      id: 110,
      name: "ziyuan",
      nickname: "garry"
    );
    userModel?.saveUser(user);

    // Get.back(result: true);
    return true;
  }

  void back() {
    Get.back(result: false);
  }
}
