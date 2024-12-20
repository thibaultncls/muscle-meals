import 'package:flutter/material.dart';
import 'package:muscle_meals/style/colors.dart';

class CustomProgressIndicator extends StatelessWidget {
  final Color? color;
  const CustomProgressIndicator({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 22,
        width: 22,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          backgroundColor: AppColors.clearGrey,
          color: color ?? AppColors.emeraldGreen,
        ));
  }
}
