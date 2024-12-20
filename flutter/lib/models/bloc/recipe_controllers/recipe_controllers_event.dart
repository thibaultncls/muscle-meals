part of 'recipe_controllers_bloc.dart';

sealed class RecipeControllersEvent extends Equatable {
  const RecipeControllersEvent();

  @override
  List<Object> get props => [];
}

final class AddIngredientEvent extends RecipeControllersEvent {
  const AddIngredientEvent();
}

final class DeleteIngredientEvent extends RecipeControllersEvent {
  final int index;
  const DeleteIngredientEvent(this.index);

  @override
  List<Object> get props => [index];
}

final class AddStepEvent extends RecipeControllersEvent {
  const AddStepEvent();
}

final class DeleteStepEvent extends RecipeControllersEvent {
  final int index;
  const DeleteStepEvent(this.index);

  @override
  List<Object> get props => [index];
}
