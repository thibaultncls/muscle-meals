part of 'difficulty_bloc.dart';

sealed class DifficultyState extends Equatable {
  final List<bool> difficultyLevel;
  const DifficultyState(this.difficultyLevel);

  @override
  List<Object> get props => [difficultyLevel];
}

final class DifficultyInitial extends DifficultyState {
  DifficultyInitial() : super([false, false, false]);
}

final class DifficultyUpdatedState extends DifficultyState {
  const DifficultyUpdatedState(super.difficultyLevel);
}
