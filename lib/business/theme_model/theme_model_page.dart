import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_frame/utils.dart';
import '../../common/user/user_record_manager.dart';
import 'theme_model_controller.dart';

class ThemeModelPage extends StatelessWidget {
  ThemeModelPage({Key? key}) : super(key: key);

  final controller = Get.put(DarkModelController());

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary.of(context),
        title: Text('darkModel'.tr, style: TextStyle(color: Colors.white, fontSize: 17.w, fontWeight: FontWeight.w500)),
        centerTitle: true,
        elevation: 0,
        leading: BackButton(
          color: themeData.colorScheme.onPrimary,
        ),
        // leading: IconButton(
        //   icon: SvgPicture.asset(
        //     ImageName.navBack,
        //     width: 16.w,
        //     height: 16.w,
        //     colorFilter: const ColorFilter.mode(Color(0xFFFFFFFF), BlendMode.srcIn),
        //   ),
        //   onPressed: () {
        //     Get.back();
        //   },
        // ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 15.w),
          GestureDetector(
            onTap: () {
              UserRecordManager.setThemeMode(2);
            },
            child: Container(
              alignment: Alignment.center,
              width: 200,
              height: 40,
              color: AppColor.primary.of(context),
              child: Text('nightModel'.tr, style: TextStyle(color: AppColor.text1.of(context))),
            ),
          ),
          SizedBox(height: 15.w),
          GestureDetector(
            onTap: () {
              UserRecordManager.setThemeMode(1);
            },
            child: Container(
              alignment: Alignment.center,
              width: 200,
              height: 40,
              color: AppColor.primary.of(context),
              child: Text('lightModel'.tr, style: TextStyle(color: AppColor.text1.of(context)),),
            ),
          ),
          SizedBox(height: 15.w),
          GestureDetector(
            onTap: () {
              UserRecordManager.setThemeMode(0);
            },
            child: Container(
              alignment: Alignment.center,
              width: 200,
              height: 40,
              color: AppColor.primary.of(context),
              child: Text('followSystem'.tr, style: TextStyle(color: AppColor.text1.of(context))),
            ),
          ),
        ],
      ),
    );
  }

}
