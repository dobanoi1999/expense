import 'package:client/core/network/exceptions/network_exception.dart';
import 'package:client/features/auth/data/models/user_model.dart';
import 'package:client/features/auth/presentation/bloc/auth_bloc.dart';

abstract class AuthRepository {
  Stream<AuthStatus> get status;
  void dispose();
  Future<ApiResponse<UserModel>> login(String email, String password);
  Future<ApiResponse<String>> register(
    String name,
    String email,
    String password,
  );
}
