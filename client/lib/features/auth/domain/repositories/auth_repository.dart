import 'package:client/features/auth/domain/entities/user.dart';
import 'package:client/features/auth/presentation/bloc/auth_bloc.dart';

abstract class AuthRepository {
  Stream<AuthStatus> get status;
  void dispose();
  Future<User> login(String email, String password);
}
