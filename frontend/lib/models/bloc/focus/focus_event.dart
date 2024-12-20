part of 'focus_bloc.dart';

sealed class FocusEvent extends Equatable {
  const FocusEvent();

  @override
  List<Object> get props => [];
}

class OnFocusEvent extends FocusEvent {
  final FocusNode focusNode;

  const OnFocusEvent(this.focusNode);

  @override
  List<Object> get props => [focusNode];
}

final class OnNextEvent extends FocusEvent {}

final class OnLastFocusEvent extends FocusEvent {
  final FocusNode focusNode;

  const OnLastFocusEvent(this.focusNode);

  @override
  List<Object> get props => [focusNode];
}
