import 'package:equatable/equatable.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class NavigationOnTap extends NavigationEvent {
  final int index;

  const NavigationOnTap(this.index);

  @override
  List<Object> get props => [index];

  @override
  String toString() => "NavigationOnTap { index: $index }";
}
