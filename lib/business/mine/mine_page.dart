import 'package:flutter/material.dart';
import 'package:flutter_frame/business/mine/setting/setting_page.dart';
import 'package:get/get.dart';
import '../../utils.dart';
import 'mine_controller.dart';
import 'mine_view_model.dart';

class MinePage extends BasePage {
  const MinePage({super.key, super.showAppBar});

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends BasePageState<MinePage> with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  late MineViewModel viewModel;

  @override
  bool get wantKeepAlive => true;

  @override
  String? get title => "mine".tr;

  @override
  void initState() {
    super.initState();
    viewModel = MineViewModel(state: this);
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
    }
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);

    Widget buildContent() {
      Widget current = Text(viewModel.list.first["title"]);
      List<Widget> children = [current];
      return EasyRefresh(
          controller: viewModel.easyRefreshController,
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
              readyText: '刷新中...',
              processingText: '刷新中...',
              processedText: '刷新完成',
              failedText: '刷新失败',
              messageText: '更新时间 %T'
          ),
          footer: ClassicFooter(
              dragText: '上拉加载',
              armedText: '释放加载',
              readyText: '加载中...',
              processingText: '加载中...',
              processedText: '加载完成',
              failedText: '加载失败',
              messageText: '更新时间 %T',
              noMoreText: "暂无更多",
              showMessage: false,
              noMoreIcon: Container(width: 20, height: 20, color: Colors.yellow,)
          ),
          onRefresh: () async {
            viewModel.refresh();
          },
          onLoad: () async {
            viewModel.loadMore();
          },
          child: GestureDetector(
            onTap: () {
              if (UserModel.shared.isLogin) {
                Get.to(const SettingPage(showAppBar: true,));
              }
            },
            child:ListView(
              children: children,
            ) ,
          ));
    }

    return ProviderWidget<MineViewModel>(
        model: viewModel,
        onModelReady: (model) {
          model.initData();
        },
        builder: (context, model, child) {
          if (model.isEmpty) {
            return XyViewStatePlaceholder(
              model,
              onTapRetry: () {
                model.loadData();
              },
            );
          }

          Widget current = buildContent();

          return current;
        });
  }
}


