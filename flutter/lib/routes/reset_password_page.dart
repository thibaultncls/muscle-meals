import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:gap/gap.dart';
import 'package:logger/web.dart';
import 'package:muscle_meals/models/bloc/password/password_bloc.dart';
import 'package:muscle_meals/models/bloc/reset_password/reset_password_bloc.dart';
import 'package:muscle_meals/models/bloc/stepper/stepper_bloc.dart';
import 'package:muscle_meals/style/colors.dart';
import 'package:muscle_meals/style/theme.dart';
import 'package:muscle_meals/utils/dialog.dart';
import 'package:muscle_meals/widgets/app_bar_title.dart';
import 'package:muscle_meals/widgets/email_field.dart';
import 'package:muscle_meals/widgets/password_checks.dart';
import 'package:muscle_meals/widgets/password_field.dart';
import 'package:muscle_meals/widgets/progress_indicator.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle('Mot de passe oublié'),
      ),
      body: BlocProvider(
        create: (context) =>
            StepperBloc(resetPasswordBloc: context.read<ResetPasswordBloc>()),
        child: BlocBuilder<StepperBloc, StepperState>(
          builder: (context, state) {
            return BlocListener<ResetPasswordBloc, ResetPasswordState>(
              listener: (context, state) {
                if (state is ResetPasswordFailureState) {
                  DialogUtils.showErrorDialog(context, state.errorMessage);
                }

                if (state is ResetPasswordSuccessfulState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.successMessage)));
                  Navigator.pop(context);
                }
              },
              child: Stepper(
                controlsBuilder: (context, details) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                        builder: (context, state) {
                          return ElevatedButton(
                            style: const ButtonStyle(
                                fixedSize:
                                    WidgetStatePropertyAll(Size(130, 40)),
                                backgroundColor: WidgetStatePropertyAll(
                                    AppColors.blueOcean)),
                            onPressed: details.onStepContinue,
                            child: (state is ResetPasswordLoadingState)
                                ? const CustomProgressIndicator(
                                    color: AppColors.blueOcean,
                                  )
                                : const Text(
                                    'Continuer',
                                    style: AppTheme.textButtonTheme,
                                  ),
                          );
                        },
                      ),
                      TextButton(
                          onPressed: details.onStepCancel,
                          child: const Text(
                            'Annuler',
                            style: TextStyle(color: AppColors.energicOrange),
                          ))
                    ],
                  );
                },
                currentStep: state.index,
                onStepContinue: () {
                  if (state is FirstStepState) {
                    Logger().d(_emailKey.currentState?.validate());
                    if (_emailKey.currentState!.validate()) {
                      context
                          .read<StepperBloc>()
                          .add(IncrementFirstStepEvent(_emailController.text));
                    }
                  } else if (state is SecondStepState) {
                    context.read<StepperBloc>().add(IncrementSecondStepEvent(
                        _emailController.text, _otpController.text));
                  } else if (state is ThirdStepState) {
                    context.read<ResetPasswordBloc>().add(DefinePasswordEvent(
                        _emailController.text, _passwordController.text));
                  }
                },
                onStepCancel: () {
                  context.read<StepperBloc>().add(DecrementStepEvent());
                },
                steps: [
                  Step(
                      title: const Text('Veuillez rentrer votre adresse email'),
                      content: Form(
                        key: _emailKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: EmailField(emailController: _emailController),
                        ),
                      )),
                  Step(
                      title: const Text('Entrez votre code de vérification'),
                      content: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Column(
                          children: [
                            OtpTextField(
                              showFieldAsBox: true,
                              disabledBorderColor: AppColors.blueOcean,
                              focusedBorderColor: AppColors.blueOcean,
                              numberOfFields: 6,
                              onSubmit: (token) {
                                _otpController.text = token;
                                Logger().d(_otpController.text);
                              },
                            ),
                            const Gap(20),
                            Text(
                              'Un code de validation a été envoyé à l\'adresse ${_emailController.text}, veuillez entrer le code si dessus',
                              style: const TextStyle(
                                  color: AppColors.secondaryText),
                            )
                          ],
                        ),
                      )),
                  Step(
                      title:
                          const Text('Définnissez votre nouveau mot de passe'),
                      content: Form(
                        key: _passwordKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: Column(
                            children: [
                              PasswordField(
                                passwordController: _passwordController,
                                onChanged: (password) {
                                  context
                                      .read<PasswordBloc>()
                                      .add(CheckPasswordEvent(password));
                                },
                              ),
                              const Gap(20),
                              const PasswordChecks()
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
