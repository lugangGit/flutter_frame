import "package:flutter/Material.dart";

import "../../common/widgets/provider/view_state_refresh_list_model.dart";


abstract class BaseViewModel extends ViewStateRefreshListModel  {
  ///判断列表数据为空
  @override
  bool get isEmpty => list.isEmpty;

  BaseViewModel({required State state});

  @override
  void dispose() {
    super.dispose();
  }
}


mixin BaseApiMixin on BaseViewModel {
  // var lastFiledId = 0;
  // String get _cacheKey => typeScreen == 0 ? 'articles${columnId}' : 'articles$xyId$typeScreen${columnId}';
  //
  // @protected
  // bool get useCache; ///是否支持缓存
  //
  // ///获取上一次缓存的首页数据
  // Map? getCacheData()  {
  //   return StorageManager.localStorage.getItem(_cacheKey);
  // }
  // ///获取新闻列表
  // Future fetchArticles(int? pageNum) async {
  //   final params = {
  //     "columnId":typeScreen == 0 ? column.id : xyId,
  //     'lastFileId': pageNum == 0 ? 0 : lastFiledId,
  //     'page': pageNum,
  //     'adv': 1,
  //     'typeScreen': typeScreen,
  //     'subColId': column.id,
  //   };
  //   var response = await http.get('getArticlesNew', queryParameters: params);
  //   if(useCache && pageNum == 0){
  //     StorageManager.localStorage.setItem(_cacheKey, response.data);
  //   }
  //   return response.data;
  // }

}