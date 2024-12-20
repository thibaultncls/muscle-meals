import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscle_meals/models/bloc/focus/focus_bloc.dart';

class Utils {
  // ! Check if the email has valid format
  static bool _isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    return emailRegex.hasMatch(email);
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez rentrer un email';
    } else if (!Utils._isValidEmail(value)) {
      return 'Veuillez rentrer un format d\'email valide';
    } else {
      return null;
    }
  }

  // ! Check if the password is valid
  static bool checkPasswordLenght(String password) {
    final passwordRegex = RegExp(r'^.{8,}$');

    return passwordRegex.hasMatch(password);
  }

  static bool containsSpecialCharacter(String password) {
    final RegExp specialCharacterRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    return specialCharacterRegex.hasMatch(password);
  }

  static bool containsUpperCase(String password) {
    final RegExp upperCaseRegex = RegExp(r'[A-Z]');

    return upperCaseRegex.hasMatch(password);
  }

  static bool containsNumber(String password) {
    final numberRegex = RegExp(r'[0-9]');

    return numberRegex.hasMatch(password);
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez rentrer un mot de passe';
    } else if (!checkPasswordLenght(value)) {
      return 'Votre mot de passe doit comporter au moins 8 caractères';
    } else if (!containsSpecialCharacter(value)) {
      return 'Votre mot de passe doit contenir au moins un caractère spécial';
    } else if (!containsUpperCase(value)) {
      return 'Votre mot de passe doit contenir une majuscule';
    } else if (!containsNumber(value)) {
      return 'Votre mot de passe doit contenir un chiffre';
    } else {
      return null;
    }
  }

  static String? recipeValidator(String? value, String errorMessage) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }
    return null;
  }

  static void addFocusBloc(
      BuildContext context, bool value, FocusNode focusNode) {
    if (value) {
      context.read<FocusBloc>().add(OnFocusEvent(focusNode));
    }
  }
}
