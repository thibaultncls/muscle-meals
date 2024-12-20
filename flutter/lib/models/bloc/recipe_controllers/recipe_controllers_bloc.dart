import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscle_meals/models/key_manager.dart';
import 'package:muscle_meals/widgets/animated_text_field.dart';

part 'recipe_controllers_event.dart';
part 'recipe_controllers_state.dart';

class RecipeControllersBloc
    extends Bloc<RecipeControllersEvent, RecipeControllersState> {
  final List<TextEditingController> _ingredientControllers;
  final List<TextEditingController> _stepControllers;
  final GlobalKey<AnimatedListState> _ingredientsKey;
  final GlobalKey<AnimatedListState> _stepsKey;
  final List<FocusNode> _ingredientNodes;
  final List<FocusNode> _stepNodes;
  final KeyManager keyManager;

  static const _duration = Duration(milliseconds: 200);

  RecipeControllersBloc(
      this._ingredientControllers,
      this._ingredientsKey,
      this._stepControllers,
      this._stepsKey,
      this._ingredientNodes,
      this._stepNodes,
      this.keyManager)
      : super(const RecipeControllersInitial()) {
    on<AddIngredientEvent>(_addRecipeController);

    on<DeleteIngredientEvent>(_deleteRecipeController);

    on<AddStepEvent>(_addStepController);

    on<DeleteStepEvent>(_deleteStepController);
  }

  Future<void> _addRecipeController(
      AddIngredientEvent event, Emitter<RecipeControllersState> emit) async {
    _ingredientsKey.currentState
        ?.insertItem(_ingredientControllers.length, duration: _duration);
    _ingredientControllers.add(TextEditingController());
    _ingredientNodes.add(FocusNode());
    keyManager.ingredientKeys.add(GlobalKey());

    emit(const IngredientListUpdated());
  }

  Future<void> _deleteRecipeController(
      DeleteIngredientEvent event, Emitter<RecipeControllersState> emit) async {
    final controller = _ingredientControllers.removeAt(event.index);
    final node = _ingredientNodes.removeAt(event.index);
    keyManager.ingredientKeys.removeAt(event.index);
    _ingredientsKey.currentState?.removeItem(
        event.index,
        (context, animation) => AnimatedTextField(
              focusNode: node,
              animation: animation,
              index: event.index,
              controller: controller,
              hintText: 'Ingrédient ${event.index + 1}',
              event: event,
            ),
        duration: _duration);
    emit(const IngredientListUpdated());
  }

  Future<void> _addStepController(
      AddStepEvent event, Emitter<RecipeControllersState> emit) async {
    _stepsKey.currentState
        ?.insertItem(_stepControllers.length, duration: _duration);
    _stepControllers.add(TextEditingController());
    _stepNodes.add(FocusNode());
    keyManager.stepKeys.add(GlobalKey());

    emit(const StepListUpdated());
  }

  Future<void> _deleteStepController(
      DeleteStepEvent event, Emitter<RecipeControllersState> emit) async {
    final controller = _stepControllers.removeAt(event.index);
    final node = _stepNodes.removeAt(event.index);
    keyManager.stepKeys.removeAt(event.index);
    _stepsKey.currentState?.removeItem(
        event.index,
        (context, animation) => AnimatedTextField(
              focusNode: node,
              animation: animation,
              index: event.index,
              controller: controller,
              hintText: 'Etape ${event.index + 1}',
              event: event,
            ));

    emit(const StepListUpdated());
  }
}
