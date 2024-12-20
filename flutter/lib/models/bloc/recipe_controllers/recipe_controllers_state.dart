part of 'recipe_controllers_bloc.dart';

sealed class RecipeControllersState extends Equatable {
  const RecipeControllersState();

  @override
  List<Object> get props => [];
}

final class RecipeControllersInitial extends RecipeControllersState {
  const RecipeControllersInitial();
}

final class IngredientListUpdated extends RecipeControllersState {
  const IngredientListUpdated();
}

final class StepListUpdated extends RecipeControllersState {
  const StepListUpdated();
}
