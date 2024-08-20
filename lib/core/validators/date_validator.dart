import '../../core/errors/errors_classes.dart';
import '../../core/errors/errors_messagens.dart';
import '../../core/validators/base_validator.dart';

final class DateValidator extends BaseValidator<String?> {
  @override
  bool validate(String? validation) {
    switch (validation?.split('/')) {
      case null || ['']:
        return throw DefaultError(MessagesError.nullStringError);
      case [var dayString, var monthString, var yearString]:
        {
          final day = int.tryParse(dayString);
          final month = int.tryParse(monthString);
          final year = int.tryParse(yearString);

          if (day == null || month == null || year == null) {
            throw InvalidDate(MessagesError.invalidDateError);
          }

          final date = DateTime(year, month, day);
          if (date.year == year && date.month == month && date.day == day) {
            return nextValidator?.validate(validation) ?? true;
          } else {
            throw InvalidDate(MessagesError.invalidDateError);
          }
        }
      default:
        return throw InvalidDate(MessagesError.invalidDateError);
    }
  }
}
