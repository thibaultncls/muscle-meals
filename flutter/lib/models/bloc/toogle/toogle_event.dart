import 'package:equatable/equatable.dart';

abstract class ToogleEvent extends Equatable {
  const ToogleEvent();

  @override
  List<Object?> get props => [];
}

class ToogleBool extends ToogleEvent {
  const ToogleBool();
}
