abstract class Regex {
  // apenas dígitos
  static final onlyNumbers = RegExp(r'[0-9]');
  // número decimal dígitos 3 pré / 2 pós vigula;
  static final onlyDecimal_3_2 =
      RegExp(r'^(?=\D*(?:\d\D*){1,5}$)\d+(?:\,\d{1,2})?$');
}
