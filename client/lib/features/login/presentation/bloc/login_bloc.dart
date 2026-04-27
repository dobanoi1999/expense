import 'package:client/core/error/bloc_error.dart';
import 'package:client/core/fomz/email.dart';
import 'package:client/core/fomz/password.dart';
import 'package:client/features/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  LoginBloc({required this.authRepository}) : super(LoginState()) {
    on<LoginEmailChanged>(_onLoginEmailChanged);
    on<LoginPasswordChanged>(_onLoginPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  void _onLoginEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
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
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);

    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.email]),
      ),
    );
  }

  void _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    final password = Password.dirty(state.password.value);
    final email = Email.dirty(state.email.value);

    Formz.validate([state.password, state.email]);
    emit(state.copyWith(password: password, email: email));
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      final response = await authRepository.login(
        state.email.value,
        state.password.value,
      );

      emit(state.copyWith(status: FormzSubmissionStatus.success));
      if (response.isSuccess) {
        await authRepository.saveToken(
          response.data!.token,
          response.data!.refreshToken,
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
        throw BlocError(response.error?.message ?? 'Error unknown');
      }
    }
  }
}
