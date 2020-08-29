import 'package:equatable/equatable.dart';
import 'package:tripadvisor/model/place.dart';
import 'package:geolocator/geolocator.dart';

abstract class FilteredSearchEvent extends Equatable {
  const FilteredSearchEvent();

  @override
  List<Object> get props => [];
}

class FilterUpdated extends FilteredSearchEvent {
  final String type;

  const FilterUpdated(this.type);

  @override
  List<Object> get props => [type];

  @override
  String toString() => "FilterUpdated { type: $type }";
}

class FilteredSearchUpdated extends FilteredSearchEvent {
  final Place pivot;
  final List<Place> nearby;
  final Position currentPosition;
  final List<String> activeFilter;

  const FilteredSearchUpdated(
    this.pivot,
    this.nearby,
    this.currentPosition,
    this.activeFilter,
  );

  @override
  List<Object> get props => [pivot, nearby, currentPosition, activeFilter];

  @override
  String toString() => "FilteredSearchUpdated";
}

class FilteredSearchUpdating extends FilteredSearchEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => "FilteredSearchUpdating";
}
