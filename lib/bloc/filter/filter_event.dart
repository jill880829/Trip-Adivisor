import 'package:equatable/equatable.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object> get props => [];
}

class FilterOnPressed extends FilterEvent {
  final int index;

  const FilterOnPressed(this.index);

  @override
  List<Object> get props => [index];

  @override
  String toString() => "FilterOnPressed { index: $index }";
}
