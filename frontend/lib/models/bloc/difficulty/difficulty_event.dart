part of 'difficulty_bloc.dart';

sealed class DifficultyEvent extends Equatable {
  const DifficultyEvent();

  @override
  List<Object> get props => [];
}

final class UpdateDifficultyEvent extends DifficultyEvent {
  final int index;

  const UpdateDifficultyEvent(this.index);

  @override
  List<Object> get props => [index];
}
