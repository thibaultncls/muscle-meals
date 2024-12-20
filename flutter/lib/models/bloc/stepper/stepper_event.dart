part of 'stepper_bloc.dart';

abstract class StepperEvent extends Equatable {
  const StepperEvent();

  @override
  List<Object> get props => [];
}

class IncrementFirstStepEvent extends StepperEvent {
  final String email;

  const IncrementFirstStepEvent(this.email);

  @override
  List<Object> get props => [email];
}

class IncrementSecondStepEvent extends StepperEvent {
  final String email;
  final String token;

  const IncrementSecondStepEvent(this.email, this.token);
}

class DecrementStepEvent extends StepperEvent {}

class ValidateFirstStepEvent extends StepperEvent {}

class ValidateSecondStepEvent extends StepperEvent {}
