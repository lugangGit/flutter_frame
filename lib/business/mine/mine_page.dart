import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'mine_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}):super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}


class _MinePageState extends State<MinePage> with WidgetsBindingObserver, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // 当界面切换到前台时执行操作
      print('界面切换到当前窗口');
      // 在这里执行你想要的操作，比如调用特定方法或更新界面等
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      // Widget内容
    );
  }
}


