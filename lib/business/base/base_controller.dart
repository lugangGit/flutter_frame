import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import 'base_state.dart';

abstract class BaseController<T> extends GetxController with BaseState {
  late BuildContext context;

  /// 分页第一页页码
  static const int PAGE_NUM_FIRST = 0;
  /// 分页条目数量
  static const int PAGE_SIZE = 20;

  ///默认 20 条，子类可以选择自定义
  int get pageSize => PAGE_SIZE;
  ///分页第一页页码 默认PAGE_NUM_FIRST 0
  int get pageNumFirst => PAGE_NUM_FIRST;

  /// 当前页码
  int _currentPageNum = PAGE_NUM_FIRST;
  ///当前页面，扩展子类判断其他逻辑使用
  int get currentPageNum => _currentPageNum;

  ///状态
  IndicatorResult? _indicatorResult;
  IndicatorResult? get indicatorResult => _indicatorResult;

  List<T> list = [];
  bool get isEmpty => list.isEmpty;

  EasyRefreshController easyRefreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  @override
  void onInit() {
    super.onInit();
    initData();
    Get.printInfo(info: 'onInit');
  }

  @override
  void onReady() {
    super.onReady();
    Get.printInfo(info: 'onReady');
  }

  @override
  void onClose() {
    super.onClose();
    Get.printInfo(info: 'onClose');
  }

  /// 第一次进入页面loading skeleton
  initData() async {
    setBusy();
    await onRefresh(init: true);
  }

  /// 下拉刷新
  ///
  /// [init] 是否是第一次加载
  /// true:  Error时,需要跳转页面
  /// false: Error时,不需要跳转页面,直接给出提示
  Future<List<T>?> onRefresh({bool init = false}) async {
    try {
      _currentPageNum = pageNumFirst;
      var data = await loadData(pageNum: pageNumFirst);
      if (data == null || data.isEmpty) {
        _indicatorResult = IndicatorResult.none;
        easyRefreshController.finishRefresh(IndicatorResult.none);
        easyRefreshController.finishLoad(IndicatorResult.none, true );
        list.clear();
        setEmpty();
        update();
      } else {
        onCompleted(data);
        list.clear();
        list.addAll(data);
        easyRefreshController.finishRefresh();
        // 小于分页的数量,禁止上拉加载更多
        if (data.length < pageSize) {
          _indicatorResult = IndicatorResult.noMore;
          easyRefreshController.finishLoad(IndicatorResult.noMore);
        } else {
          //防止上次上拉加载更多失败,需要重置状态
          easyRefreshController.resetHeader();
        }
        setIdle();
        update();
      }
      return data;
    } catch (e, s) {
      /// 页面已经加载了数据,如果刷新报错,不应该直接跳转错误页面
      /// 而是显示之前的页面数据.给出错误提示
      if (init) list.clear();
      setError(e, s);
      _indicatorResult = IndicatorResult.fail;
      easyRefreshController.finishRefresh(IndicatorResult.fail);
      update();
      return null;
    }
  }

  /// 上拉加载更多
  Future<List<T>?> loadMore() async {
    try {
      var data = await loadData(pageNum: ++_currentPageNum);
      if (data.isEmpty) {
        _currentPageNum--;
        _indicatorResult = IndicatorResult.noMore;
        easyRefreshController.finishLoad(IndicatorResult.noMore);
      } else {
        onCompleted(data);
        list.addAll(data);
        if (data.length < pageSize) {
          _indicatorResult = IndicatorResult.noMore;
          easyRefreshController.finishLoad(IndicatorResult.noMore);
        } else {
          easyRefreshController.finishLoad(IndicatorResult.success);
        }
        update();
      }
      return data;
    } catch (e, s) {
      _currentPageNum--;
      easyRefreshController.finishLoad(IndicatorResult.fail);
      return null;
    }
  }

  /// 加载数据
  Future<List<T>> loadData({int pageNum});

  onCompleted(List<T> data) {}

}
