import 'package:flutter/material.dart';
import 'package:flutter_frame/business/dark_model/dark_model_page.dart';
import 'package:flutter_frame/common/user/user_record_manager.dart';
import 'package:get/get.dart';
import '../../utils.dart';
import 'home_controller.dart';
import '../../root_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    controller.context = context;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary.of(context),
        title: Text('home'.tr, style: TextStyle(color: Colors.white, fontSize: 17.w, fontWeight: FontWeight.w500)),
        centerTitle: true,
        elevation: 0,
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) {
          if (!controller.list.isEmpty) {
            return const Center(
              child: Text('暂无内容'),
            );
          } else {
            return EasyRefresh(
                controller: controller.easyRefreshController,
                refreshOnStart: false,
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
                child: ListView(
                  children: [
                    SizedBox(height: 15.w),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => DarkModelPage(), arguments: {"isEdit": false});
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 200,
                        height: 40,
                        color: AppColor.primary.of(context),
                        child: Text('darkModel'.tr, style: TextStyle(color: AppColor.text1.of(context))),
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
                        child: Text('language'.tr, style: TextStyle(color: AppColor.text1.of(context))),
                      ),
                    ),
                  ],
                ));
          }
        },
      ),
    );
  }
}