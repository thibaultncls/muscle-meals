part of 'stepper_bloc.dart';

abstract class StepperState extends Equatable {
  final int index;

  const StepperState(this.index);

  @override
  List<Object?> get props => [index];
}

class FirstStepState extends StepperState {
  const FirstStepState() : super(0);
}

class SecondStepState extends StepperState {
  const SecondStepState() : super(1);
}

class ThirdStepState extends StepperState {
  const ThirdStepState() : super(2);
}
