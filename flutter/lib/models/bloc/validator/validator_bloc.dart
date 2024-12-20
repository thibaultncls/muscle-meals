import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscle_meals/models/controller_manager.dart';

part 'validator_event.dart';
part 'validator_state.dart';

class ValidatorBloc extends Bloc<ValidatorEvent, ValidatorState> {
  final ControllerManager controllerManager;

  ValidatorBloc(this.controllerManager) : super(ValidatorInitial()) {
    on<ValidateEvent>(_validate);
  }

  Future<void> _validate(
      ValidateEvent event, Emitter<ValidatorState> emit) async {
    _validateTextField(controllerManager.prepTimeController, emit,
        PrepTimeErrorState(), PrepTimeValidateState());

    _validateTextField(controllerManager.calorieController, emit,
        CalorieErrorState(), CalorieValidateState());

    _validateTextField(controllerManager.proteinController, emit,
        ProteinErrorState(), ProteinValidateState());

    _validateTextField(controllerManager.carbController, emit, CarbErrorState(),
        CarbValidateState());

    _validateTextField(controllerManager.fatController, emit, FatErrorState(),
        FatValidateState());

    if (controllerManager.prepTimeController.text.isNotEmpty &&
        controllerManager.calorieController.text.isNotEmpty &&
        controllerManager.proteinController.text.isNotEmpty &&
        controllerManager.carbController.text.isNotEmpty &&
        controllerManager.fatController.text.isNotEmpty) {
      emit(FormValidateState());
    } else if (controllerManager.ingredientControllers.first.text.isEmpty) {
      emit(const IngredientErrorState(
          errorMessage: 'Veuillez ajouter au moins un ingrédient'));
    } else if (controllerManager.stepControllers.first.text.isEmpty) {
      emit(const StepErrorState(
          errorMessage: 'Veuillez ajouter au moins une étape'));
    } else {
      emit(const FormErrorState(
          errorMessage: 'Tous les champs doivent être rempli'));
    }
  }

  void _validateTextField(
    TextEditingController controller,
    Emitter<ValidatorState> emit,
    ValidatorState errorState,
    ValidatorState validateState,
  ) {
    if (controller.text.isEmpty) {
      emit(errorState);
    } else {
      emit(validateState);
    }
  }
}
