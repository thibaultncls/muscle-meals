import 'package:flutter/material.dart';
import 'package:muscle_meals/style/colors.dart';

class AppBarTitle extends StatelessWidget {
  final String title;
  const AppBarTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 28,
          color: AppColors.charcoalBlack),
    );
  }
}
