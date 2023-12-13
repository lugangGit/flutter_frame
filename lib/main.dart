import 'package:flutter/material.dart';
import 'package:flutter_frame/common/user/user_record_manager.dart';
import 'package:flutter_frame/root_page.dart';
import 'business/agreement/agreement_page.dart';
import 'lang/translation_service.dart';
import 'utils.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // 初始化request类
  HttpUtils.init(
    baseUrl: Api.baseUrl,
  );

  ///初始化缓存管理
  try {
    await StorageManager.init();
  } catch (error) {
    StorageManager.localStorage.clear();
    await StorageManager.init();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: true,
      title: '万元宝',
      translations: TranslationService(),
      locale: UserRecordManager.getLocale() ?? TranslationService.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      theme: ThemeData(
          fontFamily: 'PingFangSC',
          useMaterial3: true,
          brightness: Brightness.light,
          primaryColor: Colors.blue
      ),
      darkTheme: ThemeData(
          fontFamily: 'PingFangSC',
          useMaterial3: true,
          brightness: Brightness.dark,
          primaryColor: Colors.blue[100]
      ),
      themeMode: UserRecordManager.getThemeMode(),
      // supportedLocales: IMKitClient.supportedLocales,
      // localizationsDelegates: [
      //   DefaultMaterialLocalizations.delegate,
      //   DefaultWidgetsLocalizations.delegate,
      //   ChatKitClient.delegate,
      // ],
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      // home: GestureDetector(
      //   onTap: () {
      //     print('点击空白处');
      //     hideKeyboard(context);
      //   },
      //   child: spUtil.getBool("agreedPrivacy") == true ? const RootPage() : AgreementPage(),
      // ),
      builder: EasyLoading.init(),
    );
  }
}
