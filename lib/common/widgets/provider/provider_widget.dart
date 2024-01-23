import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Provider封装类
///
/// 方便数据初始化
class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  final ValueWidgetBuilder<T> builder;
  final T model;
  final Widget? child;
  final Function(T model)? onModelReady;
  final bool autoDispose;
  final String? pageName;

  final TransitionBuilder? transitionBuilder;

  const ProviderWidget({
    Key? key,
    required this.builder,
    required this.model,
    this.child,
    this.onModelReady,
    this.autoDispose = true,
    this.pageName,
    this.transitionBuilder,
  }) : super(key: key);

  _ProviderWidgetState<T> createState() => _ProviderWidgetState<T>();
}

class _ProviderWidgetState<T extends ChangeNotifier> extends State<ProviderWidget<T>> {
  late T model;

  @override
  void initState() {
    model = widget.model;
    widget.onModelReady?.call(model);
    super.initState();
    ///页面加载成功后，更新个人积分8
    // WidgetsBinding.instance.addPostFrameCallback((callback){
    //   if( widget.pageName == PageName.newsDetail
    //       || widget.pageName == PageName.activityDetail || widget.pageName == PageName.groupImages
    //       || widget.pageName == PageName.videoDetail || widget.pageName == PageName.liveDetail
    //       || widget.pageName == PageName.specialDetail || widget.pageName == PageName.digitalNews) {
    //       StatisticsManager.pageDidShow(widget.pageName);
    //   }
    // });
  }

  @override
  void dispose() {
    if (widget.autoDispose) model.dispose();
    // StatisticsManager.pageDidDispose(widget.pageName);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: model,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }

// @override
// void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//   super.debugFillProperties(properties);
//   properties.add(DiagnosticsProperty<T>('model', model));
// }
}

class ProviderWidget2<A extends ChangeNotifier, B extends ChangeNotifier>
    extends StatefulWidget {
  final Widget Function(BuildContext context, A model1, B model2, Widget? child) builder;
  final A model1;
  final B model2;
  final Widget? child;
  final Function(A? model1, B? model2)? onModelReady;
  final bool autoDispose;

  ProviderWidget2({
    Key? key,
    required this.builder,
    required this.model1,
    required this.model2,
    this.child,
    this.onModelReady,
    this.autoDispose = true,
  }) : super(key: key);

  _ProviderWidgetState2<A, B> createState() => _ProviderWidgetState2<A, B>();
}

class _ProviderWidgetState2<A extends ChangeNotifier, B extends ChangeNotifier>
    extends State<ProviderWidget2<A, B>> {
  A? model1;
  B? model2;

  @override
  void initState() {
    model1 = widget.model1;
    model2 = widget.model2;
    widget.onModelReady?.call(model1, model2);
    super.initState();
  }

  @override
  void dispose() {
    if (widget.autoDispose) {
      model1?.dispose();
      model2?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<A?>.value(value: model1),
          ChangeNotifierProvider<B?>.value(value: model2),
        ],
        child: Consumer2<A, B>(
          builder: widget.builder,
          child: widget.child,
        ));
  }
}


class ProviderWidget3<T extends ChangeNotifier> extends StatefulWidget {
  final TransitionBuilder? builder;
  final T model;
  final Widget? child;
  final Function(T model)? onModelReady;
  final bool autoDispose;
  final String? pageName;


  const ProviderWidget3({
    Key? key,
    required this.builder,
    required this.model,
    this.child,
    this.onModelReady,
    this.autoDispose = true,
    this.pageName,
  }) : super(key: key);

  _ProviderWidgetState3<T> createState() => _ProviderWidgetState3<T>();
}

class _ProviderWidgetState3<T extends ChangeNotifier> extends State<ProviderWidget<T>> {
  late T model;

  @override
  void initState() {
    model = widget.model;
    widget.onModelReady?.call(model);
    super.initState();
    ///页面加载成功后，更新个人积分8
    // WidgetsBinding.instance.addPostFrameCallback((callback){
    //   if( widget.pageName == PageName.newsDetail
    //       || widget.pageName == PageName.activityDetail || widget.pageName == PageName.groupImages
    //       || widget.pageName == PageName.videoDetail || widget.pageName == PageName.liveDetail
    //       || widget.pageName == PageName.specialDetail || widget.pageName == PageName.digitalNews) {
    //       StatisticsManager.pageDidShow(widget.pageName);
    //   }
    // });
  }

  @override
  void dispose() {
    if (widget.autoDispose) model.dispose();
    // StatisticsManager.pageDidDispose(widget.pageName);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => model,
      builder: widget.transitionBuilder,
      child: widget.child,
    );
  }

// @override
// void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//   super.debugFillProperties(properties);
//   properties.add(DiagnosticsProperty<T>('model', model));
// }
}
