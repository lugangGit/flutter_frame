import 'package:easy_refresh/easy_refresh.dart';
import 'view_state_list_model.dart';

/// 基于
abstract class ViewStateRefreshListModel<T> extends ViewStateListModel<T> {
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

  EasyRefreshController easyRefreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  /// 下拉刷新
  ///
  /// [init] 是否是第一次加载
  /// true:  Error时,需要跳转页面
  /// false: Error时,不需要跳转页面,直接给出提示
  Future<List<T>?> refresh({bool init = false}) async {
    try {
      _currentPageNum = pageNumFirst;
      var data = await loadData(pageNum: pageNumFirst);
      if (data == null || data.isEmpty) {
        easyRefreshController.finishRefresh(IndicatorResult.none);
        easyRefreshController.finishLoad(IndicatorResult.none, true );
        list.clear();
        setEmpty();
      } else {
        onCompleted(data);
        list.clear();
        list.addAll(data);
        easyRefreshController.finishRefresh();
        // 小于分页的数量,禁止上拉加载更多
        if (data.length < pageSize) {
          easyRefreshController.finishLoad(IndicatorResult.noMore);
        } else {
          //防止上次上拉加载更多失败,需要重置状态
          easyRefreshController.resetHeader();
        }
        setIdle();
      }
      return data;
    } catch (e, s) {
      /// 页面已经加载了数据,如果刷新报错,不应该直接跳转错误页面
      /// 而是显示之前的页面数据.给出错误提示
      _currentPageNum--;
      easyRefreshController.finishLoad(IndicatorResult.fail);
      setError(e, s);
      return null;
    }
  }

  /// 上拉加载更多
  Future<List<T>?> loadMore() async {
    try {
      var data = await loadData(pageNum: ++_currentPageNum);
      if (data.isEmpty) {
        _currentPageNum--;
        easyRefreshController.finishLoad(IndicatorResult.noMore);
      } else {
        onCompleted(data);
        list.addAll(data);
        if (data.length < pageSize) {
          easyRefreshController.finishLoad(IndicatorResult.noMore);
        } else {
          easyRefreshController.finishLoad(IndicatorResult.success);
        }
        notifyListeners();
      }
      return data;
    } catch (e, s) {
      _currentPageNum--;
      easyRefreshController.finishLoad(IndicatorResult.fail);
      return null;
    }
  }

  // 加载数据
  Future<List<T>> loadData({int pageNum});

  @override
  void dispose() {
    easyRefreshController.dispose();
    super.dispose();
  }
}
