import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscle_meals/utils/utils.dart';

part 'password_event.dart';
part 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  PasswordBloc() : super(const PasswordInitialState(false)) {
    on<CheckPasswordEvent>((event, emit) {
      final isLengthValid = Utils.checkPasswordLenght(event.password);
      final hasSpecialChar = Utils.containsSpecialCharacter(event.password);
      final hasUpperCase = Utils.containsUpperCase(event.password);
      final hasNumber = Utils.containsNumber(event.password);

      emit(ValidLenghtState(isLengthValid));
      emit(ContainsUpperCaseState(hasUpperCase));
      emit(ContainsNumberState(hasNumber));
      emit(ContainsSpecialCharState(hasSpecialChar));
    });
  }
}
