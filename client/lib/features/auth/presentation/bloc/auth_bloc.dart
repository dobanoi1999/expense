import 'package:client/features/auth/domain/entities/user.dart';
import 'package:client/features/auth/domain/usecases/login_usecase.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  AuthBloc({required this.loginUseCase})
    : super(AuthState(status: AuthStatus.unknown)) {
    on((event, emit) {});
  }
}
