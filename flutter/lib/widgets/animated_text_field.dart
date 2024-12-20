import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscle_meals/models/bloc/focus/focus_bloc.dart';
import 'package:muscle_meals/models/bloc/recipe_controllers/recipe_controllers_bloc.dart';
import 'package:muscle_meals/style/colors.dart';
import 'package:muscle_meals/style/theme.dart';
import 'package:muscle_meals/utils/utils.dart';

class AnimatedTextField extends StatelessWidget {
  final Animation<double> animation;
  final int index;
  final TextEditingController controller;
  final String hintText;
  final RecipeControllersEvent event;
  final FocusNode focusNode;
  const AnimatedTextField(
      {super.key,
      required this.animation,
      required this.index,
      required this.controller,
      required this.hintText,
      required this.event,
      required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      child: Row(
        children: [
          Flexible(
            child: Focus(
              onFocusChange: (value) {
                Utils.addFocusBloc(context, value, focusNode);
                context.read<FocusBloc>().add(OnLastFocusEvent(focusNode));
              },
              child: TextField(
                autocorrect: false,
                focusNode: focusNode,
                controller: controller,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    hintText: hintText,
                    focusedBorder: AppTheme.recipeInputBorder,
                    disabledBorder: AppTheme.recipeInputBorder,
                    enabledBorder: AppTheme.recipeInputBorder),
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                context.read<RecipeControllersBloc>().add(event);
              },
              icon: const Icon(
                Icons.delete_outline,
                color: AppColors.dynamicRed,
              ))
        ],
      ),
    );
  }
}
