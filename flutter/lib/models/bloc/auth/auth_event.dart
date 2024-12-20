part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CreateUserEvent extends AuthEvent {
  final String email;
  final String password;

  const CreateUserEvent(this.email, this.password);
}

class AuthUserEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthUserEvent(this.email, this.password);
}

class ValidUserEvent extends AuthEvent {}

class RefreshTokenEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}
