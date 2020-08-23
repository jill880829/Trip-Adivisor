import 'package:equatable/equatable.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object> get props => [];
}

class FilterOnPressed extends FilterEvent {
  final String type;

  const FilterOnPressed(this.type);

  @override
  List<Object> get props => [type];

  @override
  String toString() => "FilterOnPressed { type: $type }";
}

class FilterClear extends FilterEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => "FilterClear";
}