import 'package:flutter/material.dart';
import 'package:flutter_frame/common/widgets/placeholder/view_state_placeholder.dart';
import '../provider/view_state_model.dart';
import '../../constant.dart';

///翔宇项目的占位图，后续可以统一扩展，修改逻辑
class XyViewStatePlaceholder extends ViewStatePlaceholder {
  final Color? color;
  XyViewStatePlaceholder(
      ViewStateModel model, {
        VoidCallback? onTapRetry,
        WidgetBuilder? emptyBuild,
        WidgetBuilder? contentErrorBuild,
        WidgetBuilder? networkErrorBuild,
        double? height,
        String? title,
        this.color,
        bool showRefreshTag = true
      }) : super(
      model,
      onTapRetry: onTapRetry,
      loadingBuild: (context) {
        return const Column(
          mainAxisSize: MainAxisSize.min,
          children:[
            RepaintBoundary(
              child: Image(image: AssetImage(ImageName.pageLoading), width: 120, height: 120,),
              // child: FZImage(image:AssetImage(ImageName.page_loading),config:FZImageConfig(width: AppLoading.width,height: AppLoading.height)),
            )
          ],
        );
      },
      emptyBuild:emptyBuild??(context){
        return Text("暂无数据");
        // return  ImageHelper.assetGray(context,ImageName.page_empty);
      },
      contentErrorBuild:emptyBuild??(context){
        return Text("请求出错");
        // return  ImageHelper.assetGray(context,ImageName.page_error);
      },
      networkErrorBuild:networkErrorBuild??(context){
        return Text("网络错误，重新请求");
        // return  ImageHelper.assetGray(context,ImageName.network_error);
      },
      height: height,
      title: title,
      showRefreshTag: showRefreshTag
  );

  @override
  Widget build(BuildContext context) {
    return Container(child: super.build(context),color:color,alignment: Alignment.center);
  }
}
