import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_frame/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'business/home/home_page.dart';
import 'business/mine/mine_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [HomePage(), MinePage(showAppBar: true,)];
  final PageController _controller = PageController(initialPage: 0);

  final Color _selectedColor = const Color(0xFF237CF4);
  final Color _unSelectedColor = const Color(0xFF959AAF);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //检查更新
    });
  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        final ThemeData themeData = Theme.of(context);
        return Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
          body: PageView(
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            children: _pages,
            // 页面左右滚动触发的函数
          ),
          bottomNavigationBar: Theme(
            data: ThemeData(
              brightness: Brightness.light,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
                _controller.jumpToPage(_currentIndex);
              },
              selectedFontSize: 10.0.sp,
              unselectedFontSize: 10.0.sp,
              currentIndex: _currentIndex,
              selectedItemColor: _selectedColor,
              unselectedItemColor: _unSelectedColor,
              type: BottomNavigationBarType.fixed,
              items: [
                navBarItem(themeData.brightness == Brightness.light ? ImageName.home : ImageName.brand, 'home'.tr),
                navBarItem(ImageName.mine, 'mine'.tr),
              ],
            ),
          ),
        );
      },
    );
  }

  BottomNavigationBarItem navBarItem(String icon, String title) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(icon, height: 28.w, width: 28.w, colorFilter: ColorFilter.mode(_unSelectedColor, BlendMode.srcIn)),
      activeIcon: SvgPicture.asset(icon, height: 28.w, width: 28.w, colorFilter: ColorFilter.mode(_selectedColor, BlendMode.srcIn)),
      label: title,
    );
  }
}
