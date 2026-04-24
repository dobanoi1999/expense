import 'package:formz/formz.dart';

enum ConfirmPasswordValidationError { empty, mismatch }

class ConfirmPassword
    extends FormzInput<String, ConfirmPasswordValidationError> {
  final String password;
  const ConfirmPassword.pure({required this.password}) : super.pure('');
  const ConfirmPassword.dirty({required String value, required this.password})
    : super.dirty(value);

  @override
  ConfirmPasswordValidationError? validator(String value) {
    if (password.isEmpty) return ConfirmPasswordValidationError.empty;
    if (password != value) return ConfirmPasswordValidationError.mismatch;
    return null;
  }
}

extension ConcurrentModificationErrorX on ConfirmPasswordValidationError {
  String text() {
    switch (this) {
      case ConfirmPasswordValidationError.empty:
        return 'Please enter a password';
      case ConfirmPasswordValidationError.mismatch:
        return 'Confirm password mismatch';
    }
  }
}
