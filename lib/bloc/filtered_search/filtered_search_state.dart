import 'package:equatable/equatable.dart';
import 'package:tripadvisor/model/place.dart';
import 'package:geolocator/geolocator.dart';

abstract class FilteredSearchState extends Equatable {
  final Place pivot;
  final List<String> activeFilter;
  const FilteredSearchState(this.activeFilter, this.pivot);

  @override
  List<Object> get props => [activeFilter, pivot];
}

class FilteredSearchInitial extends FilteredSearchState {
  const FilteredSearchInitial() : super(const [], null);

  @override
  String toString() => 'FilteredSearchInitial';
}

class FilteredSearchLoadSuccess extends FilteredSearchState {
  final List<Place> nearby;
  final Position currentPosition;

  const FilteredSearchLoadSuccess(
    pivot,
    this.nearby,
    this.currentPosition,
    List<String> activeFilter,
  ) : super(activeFilter, pivot);

  @override
  List<Object> get props => [nearby, currentPosition];

  @override
  String toString() => 'FilteredSearchLoadSuccess';
}

class FilteredSearchLoadInProgress extends FilteredSearchState {
  FilteredSearchLoadInProgress(activeFilter, pivot)
      : super(activeFilter, pivot);

  @override
  List<Object> get props => [];

  @override
  String toString() => 'FilteredSearchLoadInProgress';
}
