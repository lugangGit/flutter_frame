import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_frame/common/constant.dart';

import '../../utils.dart';

/// 用户引导界面
class GuideView extends StatefulWidget {
  const GuideView({super.key});

  @override
  GuideViewState createState() => GuideViewState();
}

class GuideViewState extends State<GuideView> {
  /// 跳转最后一页滑动最大距离
  final double lastPageMaxScroll = 50;

  List images = [
    ImageName.guide1,
    ImageName.guide2,
    ImageName.guide3,
  ];

  Widget _imageItem(int pageNum, BuildContext context) {
    bool isLast = pageNum == (images.length - 1);
    return Stack(
      children: <Widget>[
        Image(image: AssetImage(images[pageNum]), width: double.infinity, height: double.infinity, fit: BoxFit.fitHeight),
        isLast
            ? Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(48.0)),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                StorageManager.sharedPreferences.setBool(SharedPreferenceKey.firstEntry, false);
                if(StorageManager.sharedPreferences.getBool(SharedPreferenceKey.agreedPrivacy) != true){
                  Navigator.of(context).pushReplacementNamed(Routes.agreement);
                }else{
                  Navigator.of(context).pushReplacementNamed(Routes.root);
                }
              },
              child: const Image(image: AssetImage(ImageName.guideButton)),
            ),
          ),
        )
            : const SizedBox(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget pageView = PageView.builder(
      itemBuilder: ((context, index) {
        return _imageItem(index,context);
      }),
      itemCount: images.length,
      scrollDirection: Axis.horizontal,
      reverse: false,
      controller: PageController(),
      physics: const ClampingScrollPhysics(),
    );
    List<Widget> children = [pageView];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: children),
    );
  }
}
