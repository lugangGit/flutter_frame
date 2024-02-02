import 'package:flutter/material.dart';
import 'package:flutter_frame/business/theme_model/theme_model_page.dart';
import 'package:flutter_frame/common/user/user_record_manager.dart';
import 'package:flutter_frame/common/utils/app_text_style.dart';
import 'package:get/get.dart';
import '../../utils.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    controller.context = context;

    Widget buildContent() {
      return ListView(
        children: [
          SizedBox(height: 15.w),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.themeModel, arguments: {"isEdit": false} );
              // Get.to(() => ThemeModelPage(), arguments: {"isEdit": false});
            },
            child: Container(
              alignment: Alignment.center,
              width: 200,
              height: 40,
              color: AppColor.primary.of(context),
              child: Text('darkModel'.tr, style: AppTextStyle.title(context)),
            ),
          ),
          SizedBox(height: 15.w),
          GestureDetector(
            onTap: () {
              var locale = UserRecordManager.getLocale();
              if (locale?.countryCode == "CN") {
                UserRecordManager.setLocale('en', 'US');
              }else {
                UserRecordManager.setLocale('zh', 'CN');
              }
            },
            child: Container(
              alignment: Alignment.center,
              width: 200,
              height: 40,
              color: AppColor.primary.of(context),
              child: Text('language'.tr, style: AppTextStyle.title(context)),
            ),
          ),
          SizedBox(height: 15.w),
          GestureDetector(
            onTap: () async {
              Map? appConfig = StorageManager.localStorage.getItem(AppLocalStorageKey.app);
              if (appConfig == null) {
                appConfig = {
                  "isRelease": false,
                  "baseUrl": "https://api.ddca.shop?s=/api/"
                };
              }else {
                if (appConfig["isRelease"] == false) {
                  appConfig = {
                    "isRelease": true,
                    "baseUrl": Api.baseUrl
                  };
                }else {
                  appConfig = {
                    "isRelease": false,
                    "baseUrl": "https://api.ddca.shop?s=/api/"
                  };
                }
              }
              StorageManager.localStorage.setItem(AppLocalStorageKey.app, appConfig);
              Http.reset(appConfig["baseUrl"]);
              UserModel.clearUserAndLogin();
              Get.offAllNamed(Routes.agreement);
              ToastUtil.show(msg: "baseUrl: https://api.ddca.shop?s=/api/");
            },
            child: Container(
              alignment: Alignment.center,
              width: 200,
              height: 40,
              color: AppColor.primary.of(context),
              child: Text('switchDomain'.tr, style: AppTextStyle.title(context)),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: AppColor.primary.of(context),
        title: Text('home'.tr, style: TextStyle(color: Colors.white, fontSize: 17.w, fontWeight: FontWeight.w500)),
        centerTitle: true,
        actions: [
          Consumer<UserModel>(
            builder: (context, userModel, child){
              return userModel.isLogin ? Text(userModel.user?.nickname ?? "") : const SizedBox();
            },
          )
        ],
        elevation: 0,
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) {
          if (controller.isEmpty) {
            return XyViewStatePlaceholder(
              controller,
              onTapRetry: () {
                controller.loadData();
              },
            );
          }
          return EasyRefresh(
              controller: controller.easyRefreshController,
              refreshOnStart: false,
              refreshOnStartHeader: BuilderHeader(
                triggerOffset: 70,
                clamping: true,
                position: IndicatorPosition.above,
                processedDuration: Duration.zero,
                builder: (ctx, state) {
                  if (state.mode == IndicatorMode.inactive ||
                      state.mode == IndicatorMode.done) {
                    return const SizedBox();
                  }
                  return Container(
                    padding: EdgeInsets.only(bottom: 100.w),
                    width: ScreenUtil().screenWidth,
                    height: state.viewportDimension,
                    alignment: Alignment.center,
                    child: Container(color: Colors.yellow, width: 50.w, height: 50.w,),
                  );
                },
              ),
              header: const ClassicHeader(
                  dragText: '下拉刷新',
                  armedText: '释放刷新',
                  readyText: '正在刷新...',
                  processedText: '刷新完成',
                  failedText: '刷新失败',
                  messageText: '更新时间 %T'
              ),
              footer: ClassicFooter(
                  dragText: '上拉加载',
                  armedText: '释放加载',
                  readyText: '加载中...',
                  processedText: '加载完成',
                  failedText: '加载失败',
                  messageText: '更新时间 %T',
                  noMoreText: "暂无更多",
                  showMessage: false,
                  noMoreIcon: Container(width: 20, height: 20, color: Colors.yellow,)
              ),
              onRefresh: () async {
                controller.onRefresh();
              },
              onLoad: () async {
                controller.loadMore();
              },
              child: buildContent()
          );
        },
      ),
    );
  }
}
