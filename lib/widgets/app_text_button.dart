import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  final String text;
  final void Function() onPress;
  final Color? buttonColor;
  final Color? textColor;
  final double? borderRadius;

  const AppTextButton({
    super.key,
    required this.text,
    required this.onPress,
     this.textColor,
    this.buttonColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        fixedSize: const Size(380, 50),
        backgroundColor: buttonColor ?? Colors.indigo[600],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 30),
        )
      ),
      onPressed: onPress,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 25,
          color: textColor ?? Colors.white,
        ),
      ),
    );
  }
}
