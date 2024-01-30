import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import '../base/base_controller.dart';

class HomeController extends BaseController {

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

  @override
  Future<List> loadData({int pageNum = 0}) async {
    await Future.delayed(const Duration(seconds: 10));
    List test = [1,2];
    return test;
  }

}
