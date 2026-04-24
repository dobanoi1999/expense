import 'dart:async';

import 'package:client/core/network/dio_client.dart';
import 'package:client/core/network/exceptions/network_exception.dart';
import 'package:client/features/auth/data/models/user_model.dart';
import 'package:client/features/auth/domain/repositories/auth_repository.dart';
import 'package:client/features/auth/presentation/bloc/auth_bloc.dart';

class AuthRepositoryImpl implements AuthRepository {
  final _controller = StreamController<AuthStatus>();
  final DioClient dio;
  AuthRepositoryImpl({required this.dio});

  @override
  Stream<AuthStatus> get status async* {
    yield AuthStatus.unauthenticated;
    yield* _controller.stream;
  }

  @override
  Future<ApiResponse<UserModel>> login(String email, String password) async {
    final response = await dio.post<UserModel>(
      'api/auth/login',
      data: {'email': email, 'password': password},
      fromJson: (json) => UserModel.fromJson(json['data']['user']),
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
  void dispose() => _controller.close();
}
