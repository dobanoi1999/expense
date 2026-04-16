import 'package:client/core/fomz/email.dart';
import 'package:client/core/fomz/password.dart';
import 'package:client/features/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginStage> {
  final AuthRepository authRepository;
  LoginBloc({required this.authRepository}) : super(LoginStage()) {
    on<LoginEmailChanged>(_onLoginEmailChanged);
    on<LoginPasswordChanged>(_onLoginPasswordChanged);
  }

  void _onLoginEmailChanged(LoginEmailChanged event, Emitter<LoginStage> emit) {
    final email = Email.dirty(event.email);

    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([state.password, email]),
      ),
    );
  }

  void _onLoginPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginStage> emit,
  ) {
    final password = Password.dirty(event.password);

    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.email]),
      ),
    );
  }
}
