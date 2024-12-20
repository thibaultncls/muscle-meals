import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationInitial()) {
    on<NavigationEvent>((event, emit) {
      switch (event.index) {
        case 0:
          emit(const NavigateProfilState());
        case 1:
          emit(const NavigateHomeState());
        case 2:
          emit(const NavigateRecipiesState());
      }
    });
  }
}
