import 'package:client/core/error/bloc_error.dart';
import 'package:client/core/fomz/confirm_password.dart';
import 'package:client/core/fomz/email.dart';
import 'package:client/core/fomz/name.dart';
import 'package:client/core/fomz/password.dart';
import 'package:client/features/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'register_state.dart';
part 'register_event.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;
  RegisterBloc({required this.authRepository}) : super(const RegisterState()) {
    on<RegisterFullNameChanged>(_onRegisterFullNameChanged);
    on<RegisterEmailChanged>(_onRegisterEmailChanged);
    on<RegisterPasswordChanged>(_onRegisterPasswordChanged);
    on<RegisterConfirmPasswordChanged>(_onRegisterConfirmPasswordChanged);
    on<RegisterSubmitted>(_onRegisterSubmittedChanged);
  }

  void _onRegisterFullNameChanged(
    RegisterFullNameChanged event,
    Emitter<RegisterState> emit,
  ) {
    final fullName = Name.dirty(event.fullName);

    emit(
      state.copyWith(
        fullName: fullName,
        isValid: Formz.validate([
          fullName,
          state.email,
          state.password,
          state.confirmPassword,
        ]),
      ),
    );
  }

  void _onRegisterEmailChanged(
    RegisterEmailChanged event,
    Emitter<RegisterState> emit,
  ) {
    final email = Email.dirty(event.email);

    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([
          state.fullName,
          email,
          state.password,
          state.confirmPassword,
        ]),
      ),
    );
  }

  void _onRegisterPasswordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final password = Password.dirty(event.password);
    final confirmPassword = ConfirmPassword.dirty(
      value: state.confirmPassword.value,
      password: event.password,
    );

    emit(
      state.copyWith(
        password: password,
        confirmPassword: confirmPassword,
        isValid: Formz.validate([
          state.fullName,
          state.email,
          password,
          confirmPassword,
        ]),
      ),
    );
  }

  void _onRegisterConfirmPasswordChanged(
    RegisterConfirmPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final confirmPassword = ConfirmPassword.dirty(
      value: event.confirmPassword,
      password: state.password.value,
    );

    emit(
      state.copyWith(
        confirmPassword: confirmPassword,
        isValid: Formz.validate([
          state.fullName,
          state.email,
          state.password,
          confirmPassword,
        ]),
      ),
    );
  }

  void _onRegisterSubmittedChanged(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    final fullName = Name.dirty(state.fullName.value);
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final confirmPassword = ConfirmPassword.dirty(
      value: state.confirmPassword.value,
      password: state.password.value,
    );

    final isValid = Formz.validate([
      fullName,
      email,
      password,
      confirmPassword,
    ]);

    if (isValid) {
      emit(
        state.copyWith(
          fullName: fullName,
          email: email,
          password: password,
          confirmPassword: confirmPassword,
          isValid: isValid,
          status: FormzSubmissionStatus.inProgress,
        ),
      );
      final response = await authRepository.register(
        fullName.value,
        email.value,
        password.value,
      );
      if (response.isSuccess) {
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
        throw BlocError(response.error?.message ?? '');
      }
    } else {
      emit(
        state.copyWith(
          fullName: fullName,
          email: email,
          password: password,
          confirmPassword: confirmPassword,
          isValid: isValid,
        ),
      );
    }
  }
}
