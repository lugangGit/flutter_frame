import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart' as d;
import 'package:flutter/foundation.dart';
import 'package:flutter_frame/common/utils/stroage_manager.dart';
import '../../utils.dart';
import '../utils/device_util.dart';
import '../utils/event_bus_utils.dart';
import 'hy_response.dart';
import 'interceptor/cache.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HttpManager {
  static final HttpManager _instance = HttpManager._internal();
  factory HttpManager() => _instance;

  static late final Dio dio;

  List<CancelToken?> pendingRequest = [];

  HttpManager._internal() {
    // BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    BaseOptions options = BaseOptions();

    dio = Dio(options);

    //添加拦截器
    //dio.interceptors.add(RequestInterceptor());
    // 添加error拦截器
    //dio.interceptors.add(ErrorInterceptor());
    // // 添加cache拦截器
    //dio.interceptors.add(NetCacheInterceptor());


    // 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
    // if (true) {
    //   (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //       (client) {
    //     client.findProxy = (uri) {
    //       return "PROXY 127.0.0.1:$PROXY_PORT";
    //     };
    //     //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
    //     client.badCertificateCallback =
    //         (X509Certificate cert, String host, int port) => true;
    //   };
    // }
  }

  // 初始化公共属性
  // [baseUrl] 地址前缀
  // [connectTimeout] 连接超时赶时间
  // [receiveTimeout] 接收超时赶时间
  // [interceptors] 基础拦截器
  void init({
    String? baseUrl,
    Duration connectTimeout = const Duration(seconds: 15),
    Duration receiveTimeout = const Duration(seconds: 15),
    Map<String, String>? headers,
    List<Interceptor>? interceptors,
  }) {
    dio.options = dio.options.copyWith(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      headers: headers ?? const {
        "Authorization": ""
      },
    );
    if (interceptors != null && interceptors.isNotEmpty) {
      dio.interceptors.addAll(interceptors);
    }

    var interceptorsWrapper = InterceptorsWrapper(onRequest:
        (RequestOptions options, RequestInterceptorHandler handler) async {
      /// 公共参数
      var queryParameters = options.queryParameters;
      var version = await DeviceUtil.appVersion();
      var deviceId = await DeviceUtil.deviceId();
      var deviceInfo = await DeviceUtil.systemVersion();
      queryParameters['appVersion'] = version;
      queryParameters['curVersions'] = 2;
      queryParameters['appID'] = 1;
      queryParameters['siteId'] = 1;
      queryParameters["longitude"] = 0;
      queryParameters["latitude"] = 0;
      if(options.path != "tipoff") {///报料接口特殊处理 这里无需传location
        queryParameters["location"] = "";
      }
      queryParameters['device'] = deviceId;
      queryParameters['deviceInfo'] = Platform.isIOS ? "iOS$deviceInfo" : "Android$deviceInfo";

      try {
        _print("┌───────────────请求数据开始─────────────── \n");
        _print("│method = ${options.method.toString()}");
        _print("│url    = ${options.uri.toString()}");
        _print("│headers= ${options.headers}");
        _print("│params = ${options.queryParameters}");
        _print("│body   = ${options.data}");
        _print("└────────────────────────────────────────\n\n");
      } catch (e) {
        _print(e);
      }

      handler.next(options);
    }, onResponse: (var response, ResponseInterceptorHandler handler) {
      _print("┌────────────────开始响应──────────────────\n");
      _print("│url  = ${response.realUri.toString()}\n");
      _print("│code = ${response.statusCode}");
      Map<String, dynamic> result = {};

      if (response.data is ResponseBody) {

      } else {
        _print("│data = ${json.encode(response.data ?? '')}");
        result = json.decode(response.data);
        response.data = result;
      }

      int code = response.data['status'];
      if (code == -1) {
        _print('===需要登录===');
        EventBusUtils.getInstance()?.fire('NeedLoginEvent');
        handler.next(response);
      } else {
        handler.next(response);
      }
      _print("└────────────────响应结束──────────────────\n\n");
    }, onError: (DioError e, ErrorInterceptorHandler handler) {
      _print("┌────────────────错误响应数据───────────────\n");
      _print("│type = ${e.type}");
      if (e.type == DioExceptionType.connectionError) {
        //_netError();
      }
      _print("│message = ${e.message}");
      _print("│stackTrace = ${e.message}");
      _print("└──────────────────────────────────────────\n");
      handler.next(e);
    });
    dio.interceptors.add(interceptorsWrapper);
  }

  static _print(Object? object) {
    if (kDebugMode) {
      print(object ?? '');
    }
  }

  // 关闭所有 pending dio
  void cancelRequests() {
    pendingRequest.map((token) => token!.cancel('dio cancel'));
  }

  // 添加认证
  // 读取本地配置
  Map<String, dynamic>? getAuthorizationHeader() {
    Map<String, dynamic>? headers = {};
    //从getx或者sputils中获取
    var accessToken = StorageManager.sharedPreferences.getString(Constant.accessToken);
    if (accessToken != null && accessToken.toString().isNotEmpty) {
      headers['ddm-token'] = accessToken;
    }
    var userId = StorageManager.sharedPreferences.getString(Constant.userId);
    if (userId != null && userId.toString().isNotEmpty) {
      headers['ddm-userid'] = userId;
    }
    // 获取是设备是ios还是安卓
    headers['ddm-term'] = Platform.isIOS ? 'iPhone' : 'android';
    // 获取设备操作系统版本号
    headers['ddm-os'] = Platform.operatingSystemVersion;
    // 获取bunduleid
    // PackageInfo info = await PackageInfo.fromPlatform();
    headers['ddm-version'] = '3.0.0';
    headers['ddm-appcode'] = 'ddm-02';
    headers['ddm-sp'] = '';
    return headers;
  }

  // 获取cancelToken , 根据传入的参数查看使用者是否有动态传入cancel，没有就生成一个
  CancelToken createDioCancelToken(CancelToken? cancelToken) {
    CancelToken token = cancelToken ?? CancelToken();
    pendingRequest.add(token);
    return token;
  }

  Future<HYResponse> get(
      String path, {
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
        bool refresh = false,
        bool noCache = !cacheEnable,
        String? cacheKey,
        bool cacheDisk = false,
      }) async {
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.copyWith(
      extra: {
        "refresh": refresh,
        "noCache": noCache,
        "cacheKey": cacheKey,
        "cacheDisk": cacheDisk,
      },
    );
    Map<String, dynamic>? _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }
    var response;
    CancelToken dioCancelToken = createDioCancelToken(cancelToken);
    response = await dio.get(
      path,
      queryParameters: params,
      options: requestOptions,
      cancelToken: dioCancelToken,
    );
    pendingRequest.remove(dioCancelToken);
    if (response.data != null) {
      return HYResponse.convertData(response);
    } else {
      return Future.value(const HYResponse(success: false));
    }
  }

  Future<HYResponse> post(
      String path, {
        Map<String, dynamic>? params,
        data,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions = requestOptions.copyWith(headers: authorization);
    }
    CancelToken dioCancelToken = createDioCancelToken(cancelToken);
    var response = await dio.post(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
      cancelToken: dioCancelToken,
    );
    pendingRequest.remove(dioCancelToken);
    if (response.data != null) {
      return HYResponse.convertData(response);
    } else {
      return Future.value(const HYResponse(success: false));
    }
  }

  Future<HYResponse> put(
      String path, {
        data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    Options requestOptions = options ?? Options();

    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions = requestOptions.copyWith(headers: authorization);
    }
    CancelToken dioCancelToken = createDioCancelToken(cancelToken);
    var response = await dio.put(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
      cancelToken: dioCancelToken,
    );
    pendingRequest.remove(dioCancelToken);
    if (response.data != null) {
      return HYResponse.convertData(response);
    } else {
      return Future.value(const HYResponse(success: false));
    }
  }

  Future<HYResponse> patch(
      String path, {
        data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions = requestOptions.copyWith(headers: authorization);
    }
    CancelToken dioCancelToken = createDioCancelToken(cancelToken);
    var response = await dio.patch(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
      cancelToken: dioCancelToken,
    );
    pendingRequest.remove(dioCancelToken);
    if (response.data != null) {
      return HYResponse.convertData(response);
    } else {
      return Future.value(const HYResponse(success: false));
    }
  }

  Future<HYResponse> delete(
      String path, {
        data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    Options requestOptions = options ?? Options();

    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions = requestOptions.copyWith(headers: authorization);
    }
    CancelToken dioCancelToken = createDioCancelToken(cancelToken);
    var response = await dio.delete(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
      cancelToken: dioCancelToken,
    );
    pendingRequest.remove(dioCancelToken);
    if (response.data != null) {
      return HYResponse.convertData(response);
    } else {
      return Future.value(const HYResponse(success: false));
    }
  }

  Future download(
      String url,
      String savePath, {
        Map<String, dynamic>? params,
        CancelToken? cancelToken,
        data,
        Options? options,
        void Function(int, int)? onReceiveProgress
      }) async {
    try {
      return await dio.download(
        url,
        savePath,
        queryParameters: params,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress
      );
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        EasyLoading.showInfo('下载已取消！');
      } else {
        if (e.response != null) {
          print(e.response);
        } else {
          EasyLoading.showError(e.toString());
        }
      }
    } on Exception catch (e) {
      EasyLoading.showError(e.toString());
    }
  }
}
