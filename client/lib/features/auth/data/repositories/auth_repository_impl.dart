import 'dart:async';

import 'package:client/core/network/dio_client.dart';
import 'package:client/features/auth/data/models/user_model.dart';
import 'package:client/features/auth/domain/entities/user.dart';
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
  Future<User> login(String email, String password) async {
    final user = await dio.post(
      'auth/login',
      data: {'email': email, 'password': password},
    );
    final userModel = UserModel.fromJson(user.data['user']);
    return userModel.toEntity();
  }

  @override
  void dispose() => _controller.close();
}
