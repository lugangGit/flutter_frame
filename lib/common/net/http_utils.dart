import 'http_manager.dart';
import 'package:dio/dio.dart';
import 'hy_response.dart';
import 'interceptor/cache.dart';

class Http {
  static void init({
    required String baseUrl,
    Duration connectTimeout = const Duration(seconds: 15),
    Duration receiveTimeout = const Duration(seconds: 15),
    List<Interceptor>? interceptors,
  }) {
    HttpManager().init(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      interceptors: interceptors,
    );
  }

  static reset(String baseUrl) {
    HttpManager.dio.options.baseUrl = baseUrl;
  }

  static Future<HYResponse> get(
      String path, {
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
        bool refresh = false,
        bool noCache = !cacheEnable,
        String? cacheKey,
        bool cacheDisk = false,
      }) async {
    return await HttpManager().get(
      path,
      params: params,
      options: options,
      cancelToken: cancelToken,
      refresh: refresh,
      noCache: noCache,
      cacheKey: cacheKey,
    );
  }

  static Future<HYResponse> post(
      String path, {
        data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    return await HttpManager().post(
      path,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }

  static Future<HYResponse> put(
      String path, {
        data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    return await HttpManager().put(
      path,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }

  static Future<HYResponse> patch(
      String path, {
        data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    return await HttpManager().patch(
      path,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }

  static Future<HYResponse> delete(
      String path, {
        data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    return await HttpManager().delete(
      path,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }

  static Future download(
      String url,
      String savePath, {
        Map<String, dynamic>? params,
        CancelToken? cancelToken,
        data,
        Options? options,
        void Function(int, int)? onReceiveProgress
      }) async {
      return await HttpManager().download(
        url,
        savePath,
        params: params,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress
      );
    }
}