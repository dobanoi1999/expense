import 'package:client/core/network/exceptions/network_exception.dart';
import 'package:client/features/auth/data/models/user_model.dart';
import 'package:client/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository;
  LoginUseCase({required this.authRepository});

  Future<ApiResponse<UserModel>> execute(String email, String password) {
    return authRepository.login(email, password);
  }
}
