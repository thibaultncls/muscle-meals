import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'difficulty_event.dart';
part 'difficulty_state.dart';

class DifficultyBloc extends Bloc<DifficultyEvent, DifficultyState> {
  DifficultyBloc() : super(DifficultyInitial()) {
    on<UpdateDifficultyEvent>(_updateDifficulty);
  }

  Future<void> _updateDifficulty(
      UpdateDifficultyEvent event, Emitter<DifficultyState> emit) async {
    switch (event.index) {
      case 0:
        emit(const DifficultyUpdatedState([true, false, false]));
      case 1:
        emit(const DifficultyUpdatedState([true, true, false]));
      case 2:
        emit(const DifficultyUpdatedState([true, true, true]));
    }
  }
}
