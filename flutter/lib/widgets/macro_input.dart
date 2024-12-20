import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:muscle_meals/style/colors.dart';
import 'package:muscle_meals/style/theme.dart';
import 'package:muscle_meals/utils/utils.dart';

class MacroInput extends StatelessWidget {
  final String input;
  final TextEditingController controller;
  final FocusNode node;
  final bool errorState;
  const MacroInput(
      {super.key,
      required this.input,
      required this.controller,
      required this.node,
      required this.errorState});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    const focusedBorder =
        OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)));
    const enabledBorder = OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.tertiaryText),
        borderRadius: BorderRadius.all(Radius.circular(8)));

    const errorBorder = OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.dynamicRed),
        borderRadius: BorderRadius.all(Radius.circular(8)));

    return Column(
      children: [
        Text(
          input,
          style: AppTheme.newRecipeStyle,
        ),
        const Text(
          'pour 100g',
          style: TextStyle(color: AppColors.secondaryText, fontSize: 12),
        ),
        const Gap(5),
        SizedBox(
          width: width * .2,
          height: 35,
          child: Focus(
            onFocusChange: (value) => Utils.addFocusBloc(context, value, node),
            child: TextFormField(
              keyboardType: TextInputType.number,
              focusNode: node,
              textInputAction: TextInputAction.next,
              controller: controller,
              decoration: InputDecoration(
                  focusedBorder: errorState ? errorBorder : focusedBorder,
                  enabledBorder: errorState ? errorBorder : enabledBorder),
            ),
          ),
        )
      ],
    );
  }
}
