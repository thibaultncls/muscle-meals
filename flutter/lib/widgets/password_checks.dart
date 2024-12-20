import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:muscle_meals/models/bloc/password/password_bloc.dart';
import 'package:muscle_meals/widgets/check_password_item.dart';

class PasswordChecks extends StatelessWidget {
  const PasswordChecks({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<PasswordBloc, PasswordState>(
          buildWhen: (previous, current) => current is ValidLenghtState,
          builder: (context, state) {
            return CheckPasswordItem(state.isValid, '8 caractères minimum');
          },
        ),
        const Gap(10),
        BlocBuilder<PasswordBloc, PasswordState>(
          buildWhen: (previous, current) => current is ContainsSpecialCharState,
          builder: (context, state) {
            return CheckPasswordItem(state.isValid, '1 caractère spécial');
          },
        ),
        const Gap(10),
        BlocBuilder<PasswordBloc, PasswordState>(
          buildWhen: (previous, current) => current is ContainsUpperCaseState,
          builder: (context, state) {
            return CheckPasswordItem(state.isValid, '1 majuscule');
          },
        ),
        const Gap(10),
        BlocBuilder<PasswordBloc, PasswordState>(
          buildWhen: (previous, current) => current is ContainsNumberState,
          builder: (context, state) {
            return CheckPasswordItem(state.isValid, '1 chiffre');
          },
        )
      ],
    );
  }
}
