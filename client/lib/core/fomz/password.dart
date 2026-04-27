import 'package:formz/formz.dart';

enum PasswordValidationError { empty, min }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure([super.value = '']) : super.pure();
  const Password.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) return PasswordValidationError.empty;
    if (value.length < 6) return PasswordValidationError.min;
    return null;
  }
}

extension PasswordValidationErrorX on PasswordValidationError {
  String text() {
    switch (this) {
      case PasswordValidationError.min:
        return 'Password must be at least 6 characters';
      case PasswordValidationError.empty:
        return 'Please enter a password';
    }
  }
}
