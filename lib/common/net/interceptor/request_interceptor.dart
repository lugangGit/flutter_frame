import 'package:dio/dio.dart';

// 网络请求处理拦截器
class RequestInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.copyWith(
      headers: {
        //"Content-type" : "application/json",
        "clientType" : "master",
      }
    );
    return super.onRequest(options, handler);
  }
}