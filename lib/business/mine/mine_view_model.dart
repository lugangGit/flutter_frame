import 'package:flutter_frame/business/base/base_view_model.dart';
import '../../utils.dart';

class MineViewModel extends BaseViewModel {
  int? userId;
  MineViewModel({required super.state, this.userId}){
    final data = StorageManager.localStorage.getItem("articlesCacheKey");
    if (data != null && data is Map) {
      ///todo
    }
  }

  @override
  Future<List> loadData({int pageNum = 0}) async {
    var data = await fetchArticles(0);
    StorageManager.localStorage.setItem("articlesCacheKey", data);
    List list = data['list'] ?? [];
    // _listAdvs = list.map((e) => AdvPosition.fromJson(e)).toList();
    return list;
  }

  Future fetchArticles(int? pageNum) async {
    final params = {
      "columnId": "336",
      'lastFileId': 0,
      'page': pageNum,
      'adv': 1,
      'typeScreen': 0,
      'subColId': "336",
      'posionColumnID': 0
    };
    var response = await Http.get('getArticlesNew', params: params);
    return response.data;
  }
}