import 'package:dio/dio.dart';

class HYResponse<T> {
  /// Response body. may have been transformed, please refer to [ResponseType].
  final T? data;
  ///  Server Message
  final int? code;
  final bool success;
  final T? message;
  final int? total;
  final List<T>? rows;

  const HYResponse({
    this.data,
    this.code,
    required this.success,
    this.message,
    this.total,
    this.rows
  });

  static Future<HYResponse> convertData(Response response) {
    bool success = response.data['code'] == 1;
    HYResponse responseData = HYResponse(
      data: response.data['data'],
      code: response.data['code'],
      success: success,
      message: response.data['msg'],
      total: response.data['total'],
      rows: response.data['rows'],
    );
    Future<HYResponse> future;
    future = Future.value(responseData);
    return future;
  }
}
