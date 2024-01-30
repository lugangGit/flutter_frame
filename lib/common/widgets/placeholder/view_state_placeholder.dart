import 'package:flutter/material.dart';
import 'package:flutter_frame/business/base/base_controller.dart';
import 'package:flutter_frame/common/widgets/placeholder/view_state_widget.dart';
import '../provider/view_state.dart';
import '../provider/view_state_model.dart';

class ViewStatePlaceholder extends StatelessWidget {
  final dynamic model;
  final VoidCallback? onTapRetry;
  final WidgetBuilder? loadingBuild;
  final WidgetBuilder? emptyBuild;
  final WidgetBuilder? contentErrorBuild;
  final WidgetBuilder? networkErrorBuild;
  final double? height;
  final String? title;
  final bool showRefreshTag;

  const ViewStatePlaceholder(
    this.model, {super.key,
    this.loadingBuild,
    this.emptyBuild,
    this.contentErrorBuild,
    this.networkErrorBuild,
    this.onTapRetry,
    this.height,
    this.title,
    this.showRefreshTag = true
  });

  @override
  Widget build(BuildContext context) {
    Widget placeholder = const SizedBox();
    if (model is ViewStateModel || model is BaseController) {
      if (model.busy) {
        placeholder = loadingBuild?.call(context) ?? const SizedBox();
      }

      ///页面加载出错，没有缓存的时候，显示加载出错
      else if (model.error) {
        ViewStateError? error = model.viewStateError;
        if (error?.errorType == ErrorType.networkError) {
          placeholder = ViewStateWidget(
            onPressed: onTapRetry,
            // image: networkErrorBuild != null
            //     ? networkErrorBuild?.call(context)
            //     : ImageHelper.assetGray(context,'assets/images/network_error.png',package: "basic"),
            // title: Text((this.title ?? error?.message) ?? "",
            // buttonTextData: showRefreshTag ? FZTag(text:strings.refresh,config:AppTagStyle.highlightOutline) : null,
            // height: height,
          );
        } else {
          placeholder = ViewStateWidget(
            onPressed: onTapRetry,
            // image: contentErrorBuild != null ? contentErrorBuild?.call(context)
            //     : ImageHelper.assetGray(context,'assets/images/page_error.png'),
            // title: Text((this.title ?? error?.message) ?? strings.pageError,style: AppTextStyle.bodySmall.of(context)),
            // buttonTextData: showRefreshTag ? FZTag(text:strings.refresh,config:AppTagStyle.highlightOutline) : null,
            // height: height,
          );
        }
      } else {
        ///页面数据为空
        placeholder = ViewStateWidget(
          onPressed: onTapRetry,
          // image: emptyBuild != null ? emptyBuild?.call(context) : ImageHelper.assetGray(context,'assets/images/page_empty.png'),
          title: const Text("内容为空"),
          // buttonTextData: showRefreshTag ? FZTag(text:strings.refresh,config:AppTagStyle.highlightOutline) : null,
          // height: height,
        );
      }
    }

    return placeholder;
  }
}
