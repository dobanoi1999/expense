import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptor extends Interceptor {
  LoggingInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint(
        '═══════════════════════════════════════════════════════════════',
      );
      debugPrint('🔵 REQUEST [${options.method}] ${options.path}');
      debugPrint('Headers: ${options.headers}');
      if (options.queryParameters.isNotEmpty) {
        debugPrint('Query Parameters: ${options.queryParameters}');
      }
      if (options.data != null) {
        debugPrint('Body: ${options.data}');
      }
      debugPrint(
        '═══════════════════════════════════════════════════════════════',
      );
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint(
        '═══════════════════════════════════════════════════════════════',
      );
      debugPrint(
        '🟢 RESPONSE [${response.statusCode}] ${response.requestOptions.path}',
      );
      debugPrint('Headers: ${response.headers}');
      debugPrint('Body: ${response.data}');
      debugPrint(
        '═══════════════════════════════════════════════════════════════',
      );
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint(
        '═══════════════════════════════════════════════════════════════',
      );
      debugPrint('🔴 ERROR [${err.type}] ${err.requestOptions.path}');
      debugPrint('Status Code: ${err.response?.statusCode}');
      debugPrint('Message: ${err.message}');
      debugPrint('Response: ${err.response?.data}');
      debugPrint(
        '═══════════════════════════════════════════════════════════════',
      );
    }
    handler.next(err);
  }
}
