import 'dart:io';

import 'package:muscle_meals/models/user.dart';

sealed class Result {
  final String message;

  const Result(this.message);
}

class SuccessUserResult extends Result {
  final User? user;

  SuccessUserResult(super.message, {this.user});
}

class SuccessImageResult extends Result {
  final File selectedImage;

  SuccessImageResult(super.message, {required this.selectedImage});
}

class RefreshTokenResult extends Result {
  RefreshTokenResult(super.message);
}

class ErrorResult extends Result {
  ErrorResult(super.message);
}
