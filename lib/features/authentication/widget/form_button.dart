import 'package:final_ch/constatns/sizes.dart';
import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    super.key,
    required this.disabled, required this.label,
  });

  final bool disabled;
  final String label;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      //비율에 따른 너비 지정
      widthFactor: 1,
      child: AnimatedContainer(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: disabled ? Colors.grey.shade800 : Colors.grey.shade100),
        duration: const Duration(
          seconds: 1,
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(seconds: 1),
          style: TextStyle(
            color: disabled ? Colors.grey : Colors.black,
            fontWeight: FontWeight.w600,
          ),
          child:  Text(
            label,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
