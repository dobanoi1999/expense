import 'dart:async';

import 'package:client/core/data/datasources/local/auth_local_datasource.dart';
import 'package:client/core/network/dio_client.dart';
import 'package:client/core/network/exceptions/network_exception.dart';
import 'package:client/features/auth/data/models/login_response_model.dart';
import 'package:client/features/auth/data/models/user_model.dart';
import 'package:client/features/auth/domain/repositories/auth_repository.dart';
import 'package:client/features/auth/presentation/bloc/auth_bloc.dart';

class AuthRepositoryImpl implements AuthRepository {
  final _controller = StreamController<AuthStatus>();
  final DioClient dio;
  final AuthLocalDataSource local;

  AuthRepositoryImpl({required this.dio, required this.local});

  @override
  Stream<AuthStatus> get status async* {
    final token = await local.getToken();
    if (token != null) {
      yield AuthStatus.authenticated;
    } else {
      yield AuthStatus.unauthenticated;
    }
    yield* _controller.stream;
  }

  @override
  Future<ApiResponse<LoginResponseModel>> login(
    String email,
    String password,
  ) async {
    final response = await dio.post<LoginResponseModel>(
      'api/auth/login',
      data: {'email': email, 'password': password},
      fromJson: (json) => LoginResponseModel.fromJson(json['data']),
    );
    if (response.isSuccess && response.data != null) {
      _controller.add(AuthStatus.authenticated);
    }
    return response;
  }

  @override
  Future<ApiResponse<String>> register(
    String name,
    String email,
    String password,
  ) async {
    return await dio.post<String>(
      'api/auth/register',
      data: {'name': name, 'email': email, 'password': password},
      fromJson: (json) => json['data']['message'],
    );
  }

  @override
  Future<ApiResponse<UserModel>> info() async {
    return await dio.get<UserModel>(
      'api/users/me',
      fromJson: (json) => UserModel.fromJson(json['data']),
    );
  }

  @override
  Future<void> saveToken(String token, String refreshToken) async {
    await local.saveToken(token);
    return await local.saveRefreshToken(refreshToken);
  }

  @override
  Future<String?> getToken() {
    return local.getToken();
  }

  @override
  Future<void> clearToken() {
    return local.clearToken();
  }

  @override
  void dispose() => _controller.close();
}
