part of 'password_bloc.dart';

abstract class PasswordEvent extends Equatable {
  const PasswordEvent();

  @override
  List<Object> get props => [];
}

class CheckPasswordEvent extends PasswordEvent {
  final String password;

  const CheckPasswordEvent(this.password);

  @override
  List<Object> get props => [password];
}
