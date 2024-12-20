part of 'validator_bloc.dart';

sealed class ValidatorEvent extends Equatable {
  const ValidatorEvent();

  @override
  List<Object> get props => [];
}

final class ValidateEvent extends ValidatorEvent {}
