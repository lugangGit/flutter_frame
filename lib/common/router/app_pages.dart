import 'package:flutter_frame/business/agreement/agreement_page.dart';
import 'package:flutter_frame/business/dark_model/dark_model_page.dart';
import 'package:flutter_frame/root_page.dart';
import 'package:flutter_frame/utils.dart';
import 'package:get/get.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final initial = StorageManager.sharedPreferences.getBool(SharedPreferenceKey.agreedPrivacy) == true ? Routes.root : Routes.agreement;

  static final routes = [
    GetPage(
        // transition: Transition.fade,
        participatesInRootNavigator: true,
        name: Routes.root,
        page: () => const RootPage()),
    GetPage(
      popGesture: true,
      name: _Paths.agreement,
      page: () => const AgreementPage(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Paths.darkModel,
      page: () =>  DarkModelPage(),
      // transition: Transition.downToUp,
    ),
  ];
}
