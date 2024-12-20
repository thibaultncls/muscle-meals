import 'package:equatable/equatable.dart';

class ToogleState extends Equatable {
  final bool value;

  const ToogleState(this.value);

  @override
  List<Object?> get props => [value];
}
