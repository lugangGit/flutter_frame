import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../net/hy_response.dart';
import 'view_state.dart';


class ViewStateModel with ChangeNotifier {
  /// 防止页面销毁后,异步任务才完成,导致报错
  bool _disposed = false;

  /// 当前的页面状态,默认为busy,可在viewModel的构造方法中指定;
  ViewState _viewState;

  /// 当前页面是否存在缓存数据
  bool _cached = false;

  /// 根据状态构造
  ///
  /// 子类可以在构造函数指定需要的页面状态
  /// FooModel():super(viewState:ViewState.busy);
  ViewStateModel({ViewState viewState = ViewState.idle}) : _viewState = viewState;

  ViewState get viewState => _viewState;

  bool get cached => _cached;

  set viewState(ViewState viewState) {
    _viewStateError = null;
    _viewState = viewState;
    notifyListeners();
  }

  ViewStateError? _viewStateError;

  ViewStateError? get viewStateError => _viewStateError;

  String? get errorMessage => _viewStateError?.message;

  /// 以下变量是为了代码书写方便,加入的get方法.严格意义上讲,并不严谨

  bool get busy => viewState == ViewState.busy;

  bool get idle => viewState == ViewState.idle;

  bool get empty => viewState == ViewState.empty;

  bool get error => viewState == ViewState.error;

  bool get unAuthorized => viewState == ViewState.unAuthorized;

  void setIdle() {
    viewState = ViewState.idle;
  }

  void setBusy() {
    viewState = ViewState.busy;
  }

  void setEmpty() {
    viewState = ViewState.empty;
  }

  void setUnAuthorized() {
    viewState = ViewState.unAuthorized;
    onUnAuthorizedException();
  }

  void setCached() {
    _cached = true;
  }

  /// 未授权的回调
  void onUnAuthorizedException() {}

  /// [e]分类Error和Exception两种
  void setError(e, stackTrace, {String? message}) {
    ErrorType errorType = ErrorType.defaultError;
    if (e is DioError) {
      e = e.error;
      if (e is UnAuthorizedException) {
        stackTrace = null;
        /// 已在onUnAuthorizedException中处理
        setUnAuthorized();
        return;
      } else if (e is NotSuccessException) {
        stackTrace = null;
        message = e.message;
      } else {
        errorType = ErrorType.networkError;
      }
    }
    viewState = ViewState.error;
    _viewStateError = ViewStateError(
      errorType,
      message: message,
      errorMessage: "内容出错！",
    );
    printErrorStack(e, stackTrace);

  }

  /// 显示错误消息
  showErrorMessage(context, {String? message}) {
    if (viewStateError != null || message != null) {
      if (viewStateError?.isNetworkError) {
        // message ??= S.of(context).viewStateMessageNetworkError;
      } else {
        message ??= viewStateError?.message;
      }
      Future.microtask(() {
//        showToast(message, context: context);
      });
    }
  }

  @override
  String toString() {
    return 'BaseModel{_viewState: $viewState, _viewStateError: $_viewStateError}';
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
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

