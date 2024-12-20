import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscle_meals/models/bloc/toogle/toogle_bloc.dart';
import 'package:muscle_meals/models/bloc/toogle/toogle_event.dart';
import 'package:muscle_meals/models/bloc/toogle/toogle_state.dart';
import 'package:muscle_meals/style/colors.dart';
import 'package:muscle_meals/utils/utils.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController passwordController;
  final void Function(String)? onChanged;
  const PasswordField(
      {super.key, required this.passwordController, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToogleBloc, ToogleState>(
      builder: (context, state) {
        return TextFormField(
          controller: passwordController,
          validator: Utils.passwordValidator,
          onChanged: onChanged,
          decoration: InputDecoration(
              hintText: 'Azerty1234.',
              labelText: 'Mot de passe',
              suffixIcon: IconButton(
                  onPressed: () =>
                      context.read<ToogleBloc>().add(const ToogleBool()),
                  icon: Icon(
                      state.value ? Icons.visibility : Icons.visibility_off))),
          textInputAction: TextInputAction.go,
          keyboardType: TextInputType.visiblePassword,
          cursorColor: AppColors.blueOcean,
          obscureText: state.value,
        );
      },
    );
  }
}
