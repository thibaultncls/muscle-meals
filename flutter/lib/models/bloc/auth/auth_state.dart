part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessfulState extends AuthState {
  final User user;

  const AuthSuccessfulState({required this.user});

  @override
  List<Object?> get props => [user];
}

class LogoutSuccessfulState extends AuthState {}

class AuthFailureState extends AuthState {
  final String errorMessage;

  const AuthFailureState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
