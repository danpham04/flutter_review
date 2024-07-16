import 'package:dio/dio.dart';
import 'package:flutter_review/global/api/api_error.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class RestClient {
  static const jsonContentType = 'application/json; charset=UTF-8';
  late Dio _dio;
  RestClient({required String baseURL}) {
    final BaseOptions options = BaseOptions(
      // base url la url chung cua toan bo cac api
      baseUrl: baseURL,
      // thoi gian toi da ket noi toi server
      connectTimeout: const Duration(seconds: 5),
      // thoi gian toi da nhan response tu server
      receiveTimeout: const Duration(seconds: 3),
      // type kieu tra ve cua restponse
      contentType: jsonContentType,
    );
    // khoi tao dio chung voi option chung cho toan bo project
    _dio = Dio(options);

    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 180));
  }

  Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final Response<dynamic> response = await _dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      throw _mapError(e);
    }
  }

  Future<dynamic> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final Response<dynamic> response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      throw _mapError(e);
    }
  }

  Future<dynamic> put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final Response<dynamic> response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      throw _mapError(e);
    }
  }

  Future<dynamic> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response<dynamic> response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      throw _mapError(e);
    }
  }

  Future<dynamic> patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final Response<dynamic> response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      throw _mapError(e);
    }
  }

  ApiError _mapError(dynamic e) {
    if (e is DioException) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          return ApiError(
              errorCode: "CONNECT_TIMEOUT",
              message: 'Có lỗi kết nối đến server');
        case DioExceptionType.sendTimeout:
          return ApiError(
              errorCode: "SENT_TIMEOUT", message: 'Có lỗi kết nối đến server');
        case DioExceptionType.receiveTimeout:
          return ApiError(
              errorCode: "RECEIVE_TIMEOUT",
              message: 'Có lỗi kết nối đến server');
        case DioExceptionType.badResponse:
          if (e.response?.data != null && e.response?.data is Map) {
            String code = '';
            try {
              dynamic errorData = e.response!.data;
              code = errorData["code"];
              if (code == '404') {
                return ApiError(
                  errorCode: code,
                  message: 'Có lỗi kết nối 404 đến server',
                  extraData: e.response?.data,
                );
              }
            } catch (error) {
              return ApiError(
                errorCode: code,
                message: 'Có lỗi đã xảy ra',
                extraData: e.response?.data,
              );
            }
          } else {
            return ApiError(
              errorCode: '404777777',
              message: 'Có lỗi đã xảy ra',
              extraData: e.response?.data,
            );
          }

        default:
      }
    }
    return ApiError(extraData: e);
  }
}
