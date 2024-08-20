import '../../core/errors/errors_classes.dart';
import '../../core/errors/errors_messagens.dart';
import '../../core/validators/base_validator.dart';

final class MinLengthStrValidator extends BaseValidator<String?> {
  final int minLength;

  MinLengthStrValidator({this.minLength = 3});

  @override
  bool validate(String? validation) {
    return switch (validation) {
      null => throw DefaultError(MessagesError.nullStringError),
      String _ when validation.length >= minLength =>
        nextValidator?.validate(validation) ?? true,
      _ => throw DefaultError(
          '${MessagesError.shoterStringError} - ($minLength Caracteres)'),
    };
  }
}
