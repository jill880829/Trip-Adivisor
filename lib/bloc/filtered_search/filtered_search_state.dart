import 'package:equatable/equatable.dart';
import 'package:tripadvisor/model/place.dart';

abstract class FilteredSearchState extends Equatable {
  final List<String> activeFilter;
  FilteredSearchState(this.activeFilter);

  @override
  List<Object> get props => [activeFilter];
}

class FilteredSearchInitial extends FilteredSearchState {
  FilteredSearchInitial() : super([]);

  @override
  String toString() => 'FilteredSearchInitial';
}

class FilteredSearchLoadSuccess extends FilteredSearchState {
  final List<Place> filteredPlaces;

  FilteredSearchLoadSuccess(this.filteredPlaces, activeFilter)
      : super(activeFilter);

  @override
  List<Object> get props => [filteredPlaces, activeFilter];

  @override
  String toString() =>
      'FilteredSearchLoadSuccess filteredPlaces: $filteredPlaces';
}

class FilteredSearchLoadInProgress extends FilteredSearchState {
  FilteredSearchLoadInProgress(activeFilter) : super(activeFilter);

  @override
  List<Object> get props => [activeFilter];

  @override
  String toString() => 'FilteredSearchLoadInProgress';
}
