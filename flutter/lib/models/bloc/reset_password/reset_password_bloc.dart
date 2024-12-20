import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:muscle_meals/models/repository/reset_password_repository.dart';
import 'package:muscle_meals/models/result.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final ResetPasswordRepository _resetPasswordRepository;
  ResetPasswordBloc(this._resetPasswordRepository)
      : super(ResetPasswordInitialState()) {
    on<RequestTokenEvent>(_requestToken);

    on<ValidateTokenEvent>(_validateToken);

    on<DefinePasswordEvent>(_defineNewPassword);
  }

  void _requestToken(
      RequestTokenEvent event, Emitter<ResetPasswordState> emit) async {
    emit(ResetPasswordLoadingState());

    final result = await _resetPasswordRepository.generateToken(event.email);
    Logger().d('Request token');

    if (result is ErrorResult) {
      emit(ResetPasswordFailureState(result.message));
    } else if (result is SuccessUserResult) {
      emit(RequestTokenSuccessfulState());
    }
  }

  void _validateToken(
      ValidateTokenEvent event, Emitter<ResetPasswordState> emit) async {
    emit(ResetPasswordLoadingState());

    final result =
        await _resetPasswordRepository.validateToken(event.email, event.token);

    if (result is ErrorResult) {
      emit(ResetPasswordFailureState(result.message));
    } else if (result is SuccessUserResult) {
      emit(ValidateTokenSuccessfulState());
    }
  }

  void _defineNewPassword(
      DefinePasswordEvent event, Emitter<ResetPasswordState> emit) async {
    emit(ResetPasswordLoadingState());

    final result = await _resetPasswordRepository.resetPassword(
        event.email, event.password);

    if (result is ErrorResult) {
      emit(ResetPasswordFailureState(result.message));
    } else if (result is SuccessUserResult) {
      emit(ResetPasswordSuccessfulState(result.message));
    }
  }
}
