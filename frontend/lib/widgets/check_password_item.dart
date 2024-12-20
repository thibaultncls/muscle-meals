import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:muscle_meals/style/colors.dart';

class CheckPasswordItem extends StatelessWidget {
  final bool passwordState;
  final String text;
  const CheckPasswordItem(this.passwordState, this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
          child: Container(
            key: ValueKey(passwordState),
            height: 18,
            width: 18,
            decoration: BoxDecoration(
                color:
                    passwordState ? AppColors.blueOcean : AppColors.clearGrey,
                border: Border.all(
                    color: !passwordState
                        ? AppColors.charcoalBlack
                        : AppColors.blueOcean),
                borderRadius: const BorderRadius.all(Radius.circular(4))),
            child: passwordState
                ? const Icon(
                    Icons.check,
                    color: AppColors.clearGrey,
                    size: 14,
                  )
                : null,
          ),
        ),
        const Gap(10),
        Text(
          text,
          style: const TextStyle(color: AppColors.charcoalBlack),
        )
      ],
    );
  }
}
