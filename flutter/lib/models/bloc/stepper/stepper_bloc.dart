import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscle_meals/models/bloc/reset_password/reset_password_bloc.dart';

part 'stepper_event.dart';
part 'stepper_state.dart';

class StepperBloc extends Bloc<StepperEvent, StepperState> {
  final ResetPasswordBloc resetPasswordBloc;
  StreamSubscription? resetPasswordSubscription;

  StepperBloc({required this.resetPasswordBloc})
      : super(const FirstStepState()) {
    //First increment step
    on<IncrementFirstStepEvent>(_onIncrementFirstStep);
    on<ValidateFirstStepEvent>(_onRequestTokenSuccessful);

    //Second increment step
    on<IncrementSecondStepEvent>(_onIncrementSecondStep);
    on<ValidateSecondStepEvent>(_validateTokenSuccessful);

    //Decrements steps
    on<DecrementStepEvent>(_onDecrementSteps);

    // Stream
    resetPasswordSubscription = resetPasswordBloc.stream.listen((state) {
      if (state is RequestTokenSuccessfulState) {
        add(ValidateFirstStepEvent());
      }
      if (state is ValidateTokenSuccessfulState) {
        add(ValidateSecondStepEvent());
      }
    });
  }

  void _onIncrementFirstStep(
      IncrementFirstStepEvent event, Emitter<StepperState> emit) {
    resetPasswordBloc.add(RequestTokenEvent(event.email));
  }

  void _onRequestTokenSuccessful(
      ValidateFirstStepEvent event, Emitter<StepperState> emit) {
    emit(const SecondStepState());
  }

  void _onIncrementSecondStep(
      IncrementSecondStepEvent event, Emitter<StepperState> emit) {
    resetPasswordBloc.add(ValidateTokenEvent(event.email, event.token));
  }

  void _validateTokenSuccessful(
      ValidateSecondStepEvent event, Emitter<StepperState> emit) {
    emit(const ThirdStepState());
  }

  void _onDecrementSteps(DecrementStepEvent event, Emitter<StepperState> emit) {
    if (state.index == 1) {
      emit(const FirstStepState());
    } else if (state.index == 2) {
      emit(const SecondStepState());
    }
  }

  @override
  Future<void> close() {
    resetPasswordSubscription?.cancel();
    return super.close();
  }
}
