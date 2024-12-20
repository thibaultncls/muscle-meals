import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:muscle_meals/models/bloc/password/password_bloc.dart';
import 'package:muscle_meals/models/bloc/auth/auth_bloc.dart';
import 'package:muscle_meals/models/bloc/toogle/toogle_bloc.dart';
import 'package:muscle_meals/models/repository/auth_repository.dart';
import 'package:muscle_meals/models/routes.dart';
import 'package:muscle_meals/style/theme.dart';
import 'package:muscle_meals/utils/dialog.dart';
import 'package:muscle_meals/widgets/app_bar_title.dart';
import 'package:muscle_meals/widgets/email_field.dart';
import 'package:muscle_meals/widgets/password_checks.dart';
import 'package:muscle_meals/widgets/password_field.dart';
import 'package:muscle_meals/widgets/progress_indicator.dart';
import 'package:muscle_meals/widgets/tab_item.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late final TabController _tabController;
  final _authRepository = AuthRepository();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle('Connection'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [TabItem('S\'inscrire'), TabItem('Se connecter')],
        ),
      ),
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: RepositoryProvider(
            create: (context) => _authRepository,
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => ToogleBloc(),
                ),
                BlocProvider(
                  create: (_) => AuthBloc(_authRepository),
                ),
                BlocProvider(create: (_) => PasswordBloc())
              ],
              child: TabBarView(
                controller: _tabController,
                children: const [RegisterBody(), LoginBody()],
              ),
            ),
          )),
    );
  }
}

class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is AuthFailureState) {
          DialogUtils.showErrorDialog(context, state.errorMessage);
        } else if (state is AuthSuccessfulState) {
          Navigator.pushReplacementNamed(
              context, RoutesGenerator.dashboardPage);
        }
      },
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EmailField(emailController: _emailController),
                const Gap(20),
                PasswordField(
                    passwordController: _passwordController,
                    onChanged: (password) {
                      context
                          .read<PasswordBloc>()
                          .add(CheckPasswordEvent(password));
                    }),
                const Gap(20),
                const PasswordChecks(),
                const Gap(80),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return ElevatedButton(
                        style: ButtonStyle(
                            fixedSize: WidgetStatePropertyAll(Size(
                                MediaQuery.of(context).size.width * 0.8, 30))),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            String email = _emailController.text;
                            String password = _passwordController.text;

                            context
                                .read<AuthBloc>()
                                .add(CreateUserEvent(email, password));
                          }
                        },
                        child: (state is! AuthLoadingState)
                            ? const Text(
                                'S\'inscrire',
                                style: AppTheme.textButtonTheme,
                              )
                            : const CustomProgressIndicator());
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is AuthFailureState) {
          DialogUtils.showErrorDialog(context, state.errorMessage);
        } else if (state is AuthSuccessfulState) {
          Navigator.pushReplacementNamed(
              context, RoutesGenerator.dashboardPage);
        }
      },
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 40),
            child: Column(
              children: [
                EmailField(emailController: _emailController),
                const Gap(20),
                PasswordField(passwordController: _passwordController),
                const Gap(20),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, RoutesGenerator.resetPasswordPage);
                    },
                    child: const Text('Mot de passe oublié ?')),
                const Gap(80),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final email = _emailController.text;
                            final password = _passwordController.text;

                            context
                                .read<AuthBloc>()
                                .add(AuthUserEvent(email, password));
                          }
                        },
                        child: state is! AuthLoadingState
                            ? const Text(
                                'Se connecter',
                                style: AppTheme.textButtonTheme,
                              )
                            : const CustomProgressIndicator());
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
