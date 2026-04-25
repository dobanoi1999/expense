import 'package:client/core/data/datasources/local/auth_local_datasource.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final AuthLocalDataSource local;
  const AuthInterceptor({required this.local});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await local.getToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }
}
