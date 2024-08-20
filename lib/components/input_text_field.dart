import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    super.key,
    required this.textEditingController,
    required this.label,
    required this.onValidator,
    this.icon,
    this.hint,
    this.inputFormatters,
    this.keyboardType,
    this.onFieldSubmitted,
    this.globalKey,
    this.focusNode,
  });

  final String label;
  final String? hint;
  final IconData? icon;
  final TextEditingController textEditingController;
  final String? Function(String? value) onValidator;
  final String? Function(String? value)? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final Key? globalKey;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: globalKey,
      controller: textEditingController,
      focusNode: focusNode,
      validator: onValidator,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        filled: true,
        label: Text(label),
        hintText: hint ?? label,
        prefixIcon: Icon(icon),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          // borderSide: BorderSide(
          //     color: Colors.grey.withOpacity(.3), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 2,
          ),
        ),
      ),
    );
  }
}
