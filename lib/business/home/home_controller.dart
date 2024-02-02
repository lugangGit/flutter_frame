import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import '../../common/net/http_utils.dart';
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
    // await Future.delayed(const Duration(seconds: 5));
    Map data = await fetchArticles(pageNum);
    List test = data["list"];
    return test;
  }

  Future fetchArticles(int? pageNum) async {
    final params = {
      "columnId": "336",
      'lastFileId': 0,
      'page': pageNum,
      'adv': 1,
      'typeScreen': 0,
      'subColId': "336",
      'posionColumnID': 0
    };
    var response = await Http.get('getArticlesNew', params: params);
    return response.data;
  }

}
