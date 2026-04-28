import 'package:client/features/auth/data/models/user_model.dart';
import 'package:client/features/auth/domain/entities/user.dart';
import 'package:client/features/auth/domain/usecases/login_usecase.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  AuthBloc({required this.loginUseCase}) : super(AuthState.unknown()) {
    on<AuthSubscriptionRequested>(
      (event, emit) => emit.onEach(
        loginUseCase.authRepository.status,
        onData: (status) async {
          switch (status) {
            case AuthStatus.authenticated:
              final userModel = await _getInfo();
              return emit(
                userModel != null
                    ? AuthState.authenticated(userModel.toEntity())
                    : const AuthState.unauthenticated(),
              );
            case AuthStatus.unauthenticated:
              return emit(AuthState.unauthenticated());
            case AuthStatus.unknown:
              return emit(AuthState.unknown());
          }
        },
        onError: addError,
      ),
    );
  }

  Future<UserModel?> _getInfo() async {
    final response = await loginUseCase.authRepository.info();
    return response.data;
  }
}
