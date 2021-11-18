import 'package:formz/formz.dart';

enum UsernameValidationError { lessFour }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([String value = '']) : super.dirty(value);

  @override
  UsernameValidationError? validator(String? value) {
    return (value?.isEmpty == true || value!.length < 4) ? UsernameValidationError.lessFour : null;
  }
}