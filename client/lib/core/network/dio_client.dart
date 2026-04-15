import 'package:client/core/network/interceptors/logging_interceptor.dart';
import 'package:client/core/network/interceptors/retry_interceptor.dart';
import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;
  DioClient._(this.dio);

  factory DioClient.create({
    required String baseUrl,
    Map<String, dynamic>? headers,
    bool enableLogging = false,
    bool enableRetry = false,
    Duration connectTimeout = const Duration(seconds: 30),
    Duration receiveTimeout = const Duration(seconds: 30),
    Duration sendTimeout = const Duration(seconds: 30),
  }) {
    final dio = Dio(BaseOptions(baseUrl: baseUrl, headers: headers));

    if (enableRetry) {
      dio.interceptors.add(RetryInterceptor(dio: dio));
    }
    if (enableLogging) {
      dio.interceptors.add(LoggingInterceptor());
    }
    return DioClient._(dio);
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
}
