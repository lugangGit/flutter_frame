import 'package:flutter_frame/business/agreement/agreement_page.dart';
import 'package:flutter_frame/business/login/login/login_page.dart';
import 'package:flutter_frame/business/theme_model/theme_model_page.dart';
import 'package:flutter_frame/common/widgets/guide_view.dart';
import 'package:flutter_frame/root_page.dart';
import 'package:flutter_frame/utils.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static String initial() {
    if (StorageManager.sharedPreferences.getBool(SharedPreferenceKey.firstEntry) != false) {
      return Routes.guideView;
    }else if(StorageManager.sharedPreferences.getBool(SharedPreferenceKey.agreedPrivacy) == true){
      return Routes.root;
    }else {
      return  Routes.agreement;
    }
  }

  static final routes = [
    GetPage(
        // transition: Transition.fade,
        participatesInRootNavigator: true,
        name: Routes.root,
        page: () => const RootPage()),
    GetPage(
      popGesture: true,
      name: _Paths.guideView,
      page: () => const GuideView(),
      transition: Transition.downToUp,
    ),
    GetPage(
      popGesture: true,
      name: _Paths.agreement,
      page: () => const AgreementPage(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Paths.themeModel,
      page: () =>  ThemeModelPage(),
      // transition: Transition.downToUp,
    ),
    GetPage(
      name: _Paths.login,
      page: () => LoginPage(),
      // transition: Transition.downToUp,
    ),
  ];
}
