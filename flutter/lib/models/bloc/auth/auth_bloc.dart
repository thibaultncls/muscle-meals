import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscle_meals/models/repository/auth_repository.dart';
import 'package:muscle_meals/models/result.dart';
import 'package:muscle_meals/models/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitialState()) {
    // API request to create a user and log in
    on<CreateUserEvent>(_createUser);

    on<AuthUserEvent>(_authUser);

    on<ValidUserEvent>(_validateUser);

    on<RefreshTokenEvent>(_refreshToken);

    on<LogoutEvent>(_logout);
  }

  void _createUser(CreateUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final result = await _authRepository.signIn(event.email, event.password);

    if (result is SuccessUserResult) {
      emit(AuthSuccessfulState(user: result.user!));
    } else {
      emit(AuthFailureState(errorMessage: (result as ErrorResult).message));
    }
  }

  void _authUser(AuthUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final result = await _authRepository.login(event.email, event.password);

    if (result is SuccessUserResult) {
      emit(AuthSuccessfulState(user: result.user!));
    } else {
      emit(AuthFailureState(errorMessage: (result as ErrorResult).message));
    }
  }

  void _validateUser(ValidUserEvent event, Emitter<AuthState> emit) async {
    final result = await _authRepository.getUser();

    if (result is SuccessUserResult) {
      emit(AuthSuccessfulState(user: result.user!));
    } else if (result is ErrorResult) {
      emit(AuthFailureState(errorMessage: result.message));
    } else if (result is RefreshTokenResult) {
      add(RefreshTokenEvent());
    }
  }

  void _refreshToken(RefreshTokenEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final result = await _authRepository.refreshToken();

    if (result is SuccessUserResult) {
      emit(AuthSuccessfulState(user: result.user!));
    } else if (result is ErrorResult) {
      emit(AuthFailureState(errorMessage: result.message));
    }
  }

  void _logout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final result = await _authRepository.deleteKey();

    if (result is SuccessUserResult) {
      emit(LogoutSuccessfulState());
    } else if (result is ErrorResult) {
      emit(AuthFailureState(errorMessage: result.message));
    }
  }
}
