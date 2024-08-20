import '../../core/errors/errors_classes.dart';
import '../../core/errors/errors_messagens.dart';
import '../../core/validators/base_validator.dart';

final class MinDoubleFromStrValidator extends BaseValidator<String?> {
  final double minValue;

  MinDoubleFromStrValidator({this.minValue = 0});

  @override
  bool validate(String? validation) {
    switch (validation) {
      case null:
        return throw DefaultError(MessagesError.nullStringError);
      case String _:
        {
          var value = double.tryParse(validation);
          if (value == null) {
            return throw DefaultError(MessagesError.nullStringError);
          }
          if (value < minValue) {
            return throw DefaultError(
                '${MessagesError.minDoubleError} - (${minValue.toStringAsFixed(2)})');
          }

          return nextValidator?.validate(validation) ?? true;
        }
    }
  }
}
