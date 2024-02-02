import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils.dart';

class BasePageElement extends StatefulElement {
  BasePageElement(StatefulWidget widget) : super(widget);

  @override
  Widget build() {
    BasePageState basePageState = state as BasePageState;
    Widget current = BasePageProxyWidget(state: basePageState);
    return current;
  }
}


class BasePageProxyWidget extends StatelessWidget {
  final BasePageState state;

  const BasePageProxyWidget({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return state.buildPage(context);
  }
}


abstract class BasePage extends StatefulWidget {
  final bool showAppBar;
  const BasePage({Key? key, this.showAppBar = false}):super(key: key);

  @override
  StatefulElement createElement() {
    return BasePageElement(this);
  }

  @override
  BasePageState createState();
}

abstract class BasePageState<T extends BasePage> extends State<BasePage> {
  @override
  void initState() {
    super.initState();
  }

  ///AppBar的标题
  String? get title => null;

  PreferredSizeWidget? buildAppBar(BuildContext context) => AppBar(
    backgroundColor: AppColor.primary.of(context),
    title: title != null ? Text(title!, style: TextStyle(color: Colors.white, fontSize: 17.w, fontWeight: FontWeight.w500)) : null,
    leading: ModalRoute.of(context)?.impliesAppBarDismissal ?? false  ? BackButton(color: AppColor.sub.of(context)) : null,
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
  );

  Widget buildPage(BuildContext context) {
    Widget page = build(context);
    return Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: widget.showAppBar ? buildAppBar(context) : null,
        body: page);
  }

  @override
  Widget build(BuildContext context) {
    return buildPage(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

}