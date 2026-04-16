part of 'login_bloc.dart';

class LoginStage extends Equatable {
  final FormzSubmissionStatus status;
  final Email email;
  final Password password;
  final bool isValid;
  const LoginStage({
    this.status = FormzSubmissionStatus.initial,
    this.password = const Password.pure(),
    this.email = const Email.pure(),
    this.isValid = false,
  });

  LoginStage copyWith({
    FormzSubmissionStatus? status,
    Email? email,
    Password? password,
    bool? isValid,
  }) {
    return LoginStage(
      email: email ?? this.email,
      status: status ?? this.status,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [email, password, status, isValid];
}
