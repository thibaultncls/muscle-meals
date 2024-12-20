part of 'reset_password_bloc.dart';

abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object?> get props => [];
}

class ResetPasswordInitialState extends ResetPasswordState {}

class ResetPasswordLoadingState extends ResetPasswordState {}

class RequestTokenSuccessfulState extends ResetPasswordState {}

class ValidateTokenSuccessfulState extends ResetPasswordState {}

class ResetPasswordSuccessfulState extends ResetPasswordState {
  final String successMessage;

  const ResetPasswordSuccessfulState(this.successMessage);
}

class ResetPasswordFailureState extends ResetPasswordState {
  final String errorMessage;

  const ResetPasswordFailureState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
