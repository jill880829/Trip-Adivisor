import 'package:equatable/equatable.dart';
import 'package:tripadvisor/model/place.dart';
import 'package:geolocator/geolocator.dart';

abstract class FilteredSearchState extends Equatable {
  final List<String> activeFilter;
  const FilteredSearchState(this.activeFilter);

  @override
  List<Object> get props => [activeFilter];
}

class FilteredSearchInitial extends FilteredSearchState {
  const FilteredSearchInitial() : super(const []);

  @override
  String toString() => 'FilteredSearchInitial';
}

class FilteredSearchLoadSuccess extends FilteredSearchState {
  final Place pivot;
  final List<Place> nearby;
  final Position currentPosition;

  const FilteredSearchLoadSuccess(
    this.pivot,
    this.nearby,
    this.currentPosition,
    List<String> activeFilter,
  ) : super(activeFilter);

  @override
  List<Object> get props => [pivot, nearby, currentPosition];

  @override
  String toString() => 'FilteredSearchLoadSuccess';
}

class FilteredSearchLoadInProgress extends FilteredSearchState {
  FilteredSearchLoadInProgress(activeFilter) : super(activeFilter);

  @override
  List<Object> get props => [];

  @override
  String toString() => 'FilteredSearchLoadInProgress';
}
