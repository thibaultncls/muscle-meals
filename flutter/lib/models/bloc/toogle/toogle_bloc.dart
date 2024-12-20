import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscle_meals/models/bloc/toogle/toogle_event.dart';
import 'package:muscle_meals/models/bloc/toogle/toogle_state.dart';

class ToogleBloc extends Bloc<ToogleEvent, ToogleState> {
  ToogleBloc() : super(const ToogleState(true)) {
    on<ToogleBool>((event, emit) {
      emit(ToogleState(!state.value));
    });
  }
}
