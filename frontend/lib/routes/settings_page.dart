import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscle_meals/models/bloc/auth/auth_bloc.dart';
import 'package:muscle_meals/models/routes.dart';
import 'package:muscle_meals/style/colors.dart';
import 'package:muscle_meals/style/theme.dart';
import 'package:muscle_meals/utils/dialog.dart';
import 'package:muscle_meals/widgets/app_bar_title.dart';
import 'package:muscle_meals/widgets/progress_indicator.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle('Paramètres'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is LogoutSuccessfulState) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RoutesGenerator.homePage, (route) => false);
                } else if (state is AuthFailureState) {
                  DialogUtils.showErrorDialog(
                      context, 'La déconnexion a échouée');
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(AppColors.energicOrange)),
                    onPressed: () =>
                        context.read<AuthBloc>().add(LogoutEvent()),
                    child: (state is! AuthLoadingState)
                        ? const Text(
                            'Déconnexion',
                            style: AppTheme.textButtonTheme,
                          )
                        : const CustomProgressIndicator());
              },
            ),
            TextButton(
                onPressed: () {},
                child: const Text(
                  'Supprimer le compte',
                  style: TextStyle(color: AppColors.dynamicRed),
                ))
          ],
        ),
      ),
    );
  }
}
