import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final Icon prefixIcon;
  final String hintText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSubmit;
  final bool? obscureText;
  final double? borderRadius;
  final Color? borderColor;
  final Color? focusBorderColor;
  final Color? hintTextColor;
  final Color? prefixIconColor;
  final Color? inputColor;

  const AppTextFormField({
    super.key,
    required this.controller,
    required this.inputType,
    required this.prefixIcon,
    required this.hintText,
    this.validator,
    this.onSubmit,
    this.suffixIcon,
    this.obscureText,
    this.borderRadius,
    this.borderColor,
    this.hintTextColor,
    this.prefixIconColor,
    this.inputColor,
    this.focusBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onFieldSubmitted: onSubmit,
      controller: controller,
      keyboardType: inputType,
      obscureText: obscureText ?? false,
      cursorColor: Colors.white,
      style: TextStyle(color: inputColor ?? Colors.white, fontSize: 18),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        suffixIconColor: Colors.white,
        prefixIcon: prefixIcon,
        prefixIconColor: WidgetStateColor.resolveWith(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.focused)) {
              return prefixIconColor ?? Colors.white;
            }
            if (states.contains(WidgetState.error)) {
              return Colors.red;
            }
            return prefixIconColor ?? Colors.white;
          },
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
          borderSide: BorderSide(
            width: 2,
            color: focusBorderColor ?? Colors.white,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
          borderSide: const BorderSide(
            color: Colors.red,
            style: BorderStyle.solid,
          ),
        ),
        filled: true,
        fillColor: Colors.transparent,
        hintText: hintText,
        hintStyle: TextStyle(color: hintTextColor ?? Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
          borderSide: BorderSide(
            color: borderColor ?? Colors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
          borderSide: BorderSide(
            color: borderColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
