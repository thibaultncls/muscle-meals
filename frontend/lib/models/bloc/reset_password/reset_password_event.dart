part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent extends Equatable {
  String get email;
  const ResetPasswordEvent();

  @override
  List<Object> get props => [email];
}

class RequestTokenEvent extends ResetPasswordEvent {
  @override
  final String email;

  const RequestTokenEvent(this.email);

  @override
  List<Object> get props => [email];
}

class ValidateTokenEvent extends ResetPasswordEvent {
  @override
  final String email;
  final String token;

  const ValidateTokenEvent(this.email, this.token);

  @override
  List<Object> get props => [email, token];
}

class DefinePasswordEvent extends ResetPasswordEvent {
  @override
  final String email;
  final String password;

  const DefinePasswordEvent(this.email, this.password);
}
