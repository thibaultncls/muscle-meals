import 'package:flutter/material.dart';
import 'package:muscle_meals/style/colors.dart';

class StarIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final bool difficultyLevel;

  const StarIcon(
      {super.key, required this.onPressed, required this.difficultyLevel});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (child, animation) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
      child: IconButton(
          key: ValueKey(difficultyLevel),
          visualDensity: VisualDensity.compact,
          onPressed: onPressed,
          icon: Icon(
            (!difficultyLevel) ? Icons.star_border_outlined : Icons.star,
            color: (!difficultyLevel)
                ? AppColors.charcoalBlack.withOpacity(.5)
                : AppColors.energicOrange,
          )),
    );
  }
}
