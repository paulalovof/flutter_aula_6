import '../errors/errors_classes.dart';
import '../errors/errors_messagens.dart';
import 'base_validator.dart';

final class MaxLengthStrValidator extends BaseValidator<String?> {
  final int maxLength;
  MaxLengthStrValidator({this.maxLength = 10});
  
  @override
  bool validate(String? validation) {
    return switch (validation) {
      null => throw DefaultError(MessagesError.nullStringError),
      String _ when validation.length <= maxLength =>
        nextValidator?.validate(validation) ?? true,
      _ => throw DefaultError(
          '${MessagesError.longerStringError} - ($maxLength Caracteres)'),
    };
  }

}
