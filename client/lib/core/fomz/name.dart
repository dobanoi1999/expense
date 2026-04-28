import 'package:formz/formz.dart';

enum NameValidationError { empty, min }

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure([super.value = '']) : super.pure();
  const Name.dirty([super.value = '']) : super.dirty();

  @override
  NameValidationError? validator(String value) {
    if (value.isEmpty) return NameValidationError.empty;
    if (value.length < 2) return NameValidationError.min;
    return null;
  }
}

extension NameValidationErrorX on NameValidationError {
  String text() {
    switch (this) {
      case NameValidationError.min:
        return 'Password must be at least 2 characters';
      case NameValidationError.empty:
        return 'Please enter a full name';
    }
  }
}
