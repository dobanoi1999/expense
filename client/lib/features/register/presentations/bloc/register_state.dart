part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final FormzSubmissionStatus status;
  final Name fullName;
  final Email email;
  final Password password;
  final ConfirmPassword confirmPassword;
  final bool isValid;

  const RegisterState({
    this.status = FormzSubmissionStatus.initial,
    this.fullName = const Name.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(password: ''),
    this.isValid = false,
  });

  RegisterState copyWith({
    FormzSubmissionStatus? status,
    Email? email,
    Name? fullName,
    Password? password,
    ConfirmPassword? confirmPassword,
    bool? isValid,
  }) {
    return RegisterState(
      status: status ?? this.status,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object?> get props => [
    fullName,
    email,
    status,
    password,
    confirmPassword,
    isValid,
  ];
}
