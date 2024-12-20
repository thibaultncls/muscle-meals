import 'package:flutter/material.dart';
import 'package:muscle_meals/style/colors.dart';
import 'package:muscle_meals/utils/utils.dart';

class EmailField extends StatelessWidget {
  final TextEditingController emailController;
  const EmailField({super.key, required this.emailController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: Utils.emailValidator,
      controller: emailController,
      decoration: const InputDecoration(
          labelText: 'Email', hintText: 'john_doe@example.com'),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      cursorColor: AppColors.blueOcean,
    );
  }
}
