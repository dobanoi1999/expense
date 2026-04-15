import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final Duration delayDuration;

  RetryInterceptor({
    required this.dio,
    this.maxRetries = 3,
    this.delayDuration = const Duration(seconds: 1),
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err) && err.requestOptions.extra['retryCount'] != null) {
      final retryCount = err.requestOptions.extra['retryCount'] as int;
      if (retryCount < maxRetries) {
        err.requestOptions.extra['retryCount'] = retryCount + 1;
        print('Retrying request... Attempt ${retryCount + 1}/$maxRetries');
        await Future.delayed(delayDuration);
        try {
          final response = await dio.fetch(err.requestOptions);
          return handler.resolve(response);
        } catch (e) {
          return super.onError(err, handler);
        }
      }
    }
    return handler.next(err);
  }

  bool _shouldRetry(DioException error) {
    // Retry on timeout, connection errors, and server errors (5xx)
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.connectionError) {
      return true;
    }

    // Retry on specific status codes
    final statusCode = error.response?.statusCode;
    if (statusCode != null && (statusCode >= 500 || statusCode == 429)) {
      return true;
    }

    return false;
  }
}
