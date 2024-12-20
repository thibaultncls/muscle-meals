part of 'password_bloc.dart';

abstract class PasswordState extends Equatable {
  final bool isValid;

  const PasswordState(this.isValid);

  @override
  List<Object> get props => [isValid];
}

class PasswordInitialState extends PasswordState {
  const PasswordInitialState(super.isValid);
}

class ValidLenghtState extends PasswordState {
  const ValidLenghtState(super.isValid);
}

class ContainsUpperCaseState extends PasswordState {
  const ContainsUpperCaseState(super.isValid);
}

class ContainsSpecialCharState extends PasswordState {
  const ContainsSpecialCharState(super.isValid);
}

class ContainsNumberState extends PasswordState {
  const ContainsNumberState(super.isValid);
}
