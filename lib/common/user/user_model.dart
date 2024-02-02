import 'package:flutter/Material.dart';
import '../../utils.dart';
import '../entity/user.dart';
import 'global_key_manager.dart';

class UserModel with ChangeNotifier {
  ///单例UserModel
  static final UserModel _singleton = UserModel._internal();
  factory UserModel() => _singleton;
  UserModel._internal(){
    var userMap = StorageManager.localStorage.getItem(AppLocalStorageKey.user);
    _user = userMap != null ? User.fromJson(userMap) : null;
  }


  static UserModel get shared => _singleton;

  User? _user;
  User? get user => _user;

  bool? _isDispose = false;

  bool get isLogin => null != _user && null != _user?.id && (_user?.id ?? 0) > 0;

  ///保存（更新）用户信息
  saveUser(User? user) {
    if (null == user) {
      return;
    }
    _user = user;
    if (false == _isDispose) {
      StorageManager.localStorage.setItem(AppLocalStorageKey.user, _user);
      if (null != _user?.id) {
        StorageManager.sharedPreferences.setInt(SharedPreferenceKey.userId, (_user?.id ?? -1));
      }
      notifyListeners();
    }
  }

  /// 清除持久化的用户数据
  clearUser({bool notifyListener = true}) async {
    _user = null;
    if (false == _isDispose) {
      StorageManager.sharedPreferences.setInt(SharedPreferenceKey.userId, 0);
      StorageManager.localStorage.deleteItem(AppLocalStorageKey.user);
      if (notifyListener) {
        notifyListeners();
      }
    }
  }

  ///清除本地用户跳转到登陆
  static void clearUserAndLogin({int tipsType = 0}) {  //tipsType 0:禁止登录  1：不支持当前类型
    var context = GlobalKeyManager.navigatorContext();
    if (null != context) {
      UserModel userModel = Provider.of<UserModel>(context, listen: false);
      if (userModel.isLogin) {
        userModel.clearUser(notifyListener: false);
        Future.delayed(const Duration(milliseconds: 800)).then((value) async {
          var value = await Get.toNamed(Routes.login, arguments: {"form": "home"} );
        });
      }
    }
  }

  @override
  void dispose() {
    _isDispose = true;
    super.dispose();
  }
}