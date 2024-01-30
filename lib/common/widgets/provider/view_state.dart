import '../../net/hy_response.dart';

/// 页面状态类型
enum ViewState {
  idle,
  busy, //加载中
  empty, //无数据
  error, //加载失败
  unAuthorized, //未登录
}


/// 错误类型
enum ErrorType {
  defaultError,
  networkError,
}


class ViewStateError {
  ErrorType errorType;
  String? message;
  String? errorMessage;

  ViewStateError(this.errorType, {this.message, this.errorMessage}) {
    message ??= errorMessage;
  }

  /// 以下变量是为了代码书写方便,加入的get方法.严格意义上讲,并不严谨
  get isNetworkError => errorType == ErrorType.networkError;

  @override
  String toString() {
    return 'ViewStateError{errorType: $errorType, message: $message, errorMessage: $errorMessage}';
  }
}


/// 接口的code没有返回为true的异常
class NotSuccessException implements Exception {
  String? message;
  HYResponse? data;

  NotSuccessException({this.message, this.data});

  NotSuccessException.fromRespData(HYResponse respData) {
    data = respData;
    message = respData.message;
  }
//  @override
//  String toString() {
//    return 'NotExpectedException{respData: $message}';
//  }
}


/// 用于未登录等权限不够,需要跳转授权页面
class UnAuthorizedException implements Exception {
  const UnAuthorizedException();

  @override
  String toString() => 'UnAuthorizedException';
}


/// [e]为错误类型 :可能为 Error , Exception ,String
/// [s]为堆栈信息
printErrorStack(e, s) {
//   LogUtil.e('''
// <-----↓↓↓↓↓↓↓↓↓↓-----error-----↓↓↓↓↓↓↓↓↓↓----->
// $e
// <-----↑↑↑↑↑↑↑↑↑↑-----error-----↑↑↑↑↑↑↑↑↑↑----->''');
//   if (s != null) LogUtil.e('''
// <-----↓↓↓↓↓↓↓↓↓↓-----trace-----↓↓↓↓↓↓↓↓↓↓----->
// $s
// <-----↑↑↑↑↑↑↑↑↑↑-----trace-----↑↑↑↑↑↑↑↑↑↑----->
//     ''');
}

