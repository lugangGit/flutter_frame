

import 'package:dio/dio.dart';

import '../../common/widgets/provider/view_state.dart';

mixin class BaseState {
  /// 当前的页面状态,默认为busy,可在viewModel的构造方法中指定;
  ViewState _viewState = ViewState.idle;
  ViewState get viewState => _viewState;

  /// 当前页面是否存在缓存数据
  bool _cached = false;
  bool get cached => _cached;

  ViewStateError? _viewStateError;
  ViewStateError? get viewStateError => _viewStateError;

  String? get errorMessage => _viewStateError?.message;

  bool get busy => viewState == ViewState.busy;

  bool get idle => viewState == ViewState.idle;

  bool get empty => viewState == ViewState.empty;

  bool get error => viewState == ViewState.error;

  bool get unAuthorized => viewState == ViewState.unAuthorized;

  set viewState(ViewState viewState) {
    _viewStateError = null;
    _viewState = viewState;
  }

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
  }

  void setCached() {
    _cached = true;
  }

  /// 未授权的回调
  void onUnAuthorizedException() {}

  /// [e]分类Error和Exception两种
  void setError(e, stackTrace, {String? message}) {
    ErrorType errorType = ErrorType.defaultError;
    if (e is DioException) {
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

}