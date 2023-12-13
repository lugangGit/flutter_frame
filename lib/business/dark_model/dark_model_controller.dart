import 'package:get/get.dart';

class DarkModelController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    var arguments = Get.arguments;
    print(arguments);
  }

  @override
  void onReady() {
    super.onReady();
    Get.printInfo(info: 'onReady');
  }
}
