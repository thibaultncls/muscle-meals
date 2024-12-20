part of 'navigation_bloc.dart';

sealed class NavigationState extends Equatable {
  final int index;
  const NavigationState(this.index);

  @override
  List<Object> get props => [index];
}

final class NavigationInitial extends NavigationState {
  const NavigationInitial() : super(1);
}

final class NavigateHomeState extends NavigationState {
  const NavigateHomeState() : super(1);
}

final class NavigateProfilState extends NavigationState {
  const NavigateProfilState() : super(0);
}

final class NavigateRecipiesState extends NavigationState {
  const NavigateRecipiesState() : super(2);
}
