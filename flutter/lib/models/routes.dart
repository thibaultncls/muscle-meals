import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscle_meals/models/bloc/auth/auth_bloc.dart';
import 'package:muscle_meals/models/bloc/password/password_bloc.dart';
import 'package:muscle_meals/models/bloc/reset_password/reset_password_bloc.dart';
import 'package:muscle_meals/models/bloc/toogle/toogle_bloc.dart';
import 'package:muscle_meals/models/repository/auth_repository.dart';
import 'package:muscle_meals/models/repository/reset_password_repository.dart';
import 'package:muscle_meals/routes/dashboard_page.dart';
import 'package:muscle_meals/routes/home_page.dart';
import 'package:muscle_meals/routes/login_page.dart';
import 'package:muscle_meals/routes/new_recipe_page.dart';
import 'package:muscle_meals/routes/reset_password_page.dart';
import 'package:muscle_meals/routes/settings_page.dart';

class RoutesGenerator {
  static const homePage = '/';
  static const loginPage = '/loginPage';
  static const dashboardPage = '/dashboard';
  static const resetPasswordPage = '/resetPasswordPage';
  static const settingsPage = '/settingsPage';
  static const newRecipePage = '/recipePage';

  RoutesGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(
            builder: (_) => RepositoryProvider(
                  create: (context) => AuthRepository(),
                  child: BlocProvider(
                    create: (context) => AuthBloc(AuthRepository()),
                    child: const HomePage(),
                  ),
                ));
      case loginPage:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case dashboardPage:
        return MaterialPageRoute(builder: (_) => const DashboardPage());
      case resetPasswordPage:
        return MaterialPageRoute(
            builder: (_) => RepositoryProvider(
                  create: (_) => ResetPasswordRepository(),
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (_) =>
                            ResetPasswordBloc(ResetPasswordRepository()),
                      ),
                      BlocProvider(
                        create: (context) => ToogleBloc(),
                      ),
                      BlocProvider(create: (_) => PasswordBloc())
                    ],
                    child: const ResetPasswordPage(),
                  ),
                ));
      case settingsPage:
        return MaterialPageRoute(
            builder: (_) => RepositoryProvider(
                  create: (context) => AuthRepository(),
                  child: BlocProvider(
                    create: (context) => AuthBloc(AuthRepository()),
                    child: const SettingsPage(),
                  ),
                ));
      case newRecipePage:
        return MaterialPageRoute(builder: (_) => const NewRecipePage());
      default:
        throw const RouteException('Route not found');
    }
  }
}

class RouteException implements Exception {
  final String message;
  const RouteException(this.message);
}
