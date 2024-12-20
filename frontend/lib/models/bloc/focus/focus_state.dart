part of 'focus_bloc.dart';

sealed class FocusState extends Equatable {
  const FocusState();

  @override
  List<Object> get props => [];
}

final class FocusInitial extends FocusState {}

final class HasFocusState extends FocusState {}

final class HasntFocusState extends FocusState {}

final class LastFocusState extends FocusState {}
