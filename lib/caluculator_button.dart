import 'package:calculator_h/custom_theme.dart';
import 'package:flutter/material.dart';
class CalculatorButton extends StatelessWidget {
  final dynamic label;
  final double width;
  final Color textColor;
  final VoidCallback? onPressed;
  CalculatorButton({
    super.key,
    this.onPressed,
    this.width = 80,
    this.label,
    this.textColor = CustomTheme.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 80,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: label == "="
                ? CustomTheme.orangeColor
                : CustomTheme.primaryColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: CustomTheme.shadowColor1,
                  offset: Offset(2, 4),
                  blurRadius: 4,
                  spreadRadius: 4),
              BoxShadow(
                  color: CustomTheme.shadowColor2,
                  offset: Offset(-2, -4),
                  blurRadius: 4,
                  spreadRadius: 4)
            ]),
        child: label is String
            ? Text(
                label=="*"?"×":label,
                style: TextStyle(
                  fontSize: 40,
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
              )
            : Icon(label, color: CustomTheme.orangeColor, size: 40),
      ),
    );
  }
}
