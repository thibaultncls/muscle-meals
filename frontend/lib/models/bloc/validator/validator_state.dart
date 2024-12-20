part of 'validator_bloc.dart';

sealed class ValidatorState extends Equatable {
  final String? errorMessage;
  const ValidatorState({this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

final class ValidatorInitial extends ValidatorState {}

final class PrepTimeErrorState extends ValidatorState {}

final class PrepTimeValidateState extends ValidatorState {}

final class CalorieErrorState extends ValidatorState {}

final class CalorieValidateState extends ValidatorState {}

final class ProteinErrorState extends ValidatorState {}

final class ProteinValidateState extends ValidatorState {}

final class CarbErrorState extends ValidatorState {}

final class CarbValidateState extends ValidatorState {}

final class FatErrorState extends ValidatorState {}

final class FatValidateState extends ValidatorState {}

final class FormValidateState extends ValidatorState {}

final class IngredientErrorState extends ValidatorState {
  const IngredientErrorState({super.errorMessage});
}

final class StepErrorState extends ValidatorState {
  const StepErrorState({super.errorMessage});
}

final class FormErrorState extends ValidatorState {
  const FormErrorState({super.errorMessage});
}
