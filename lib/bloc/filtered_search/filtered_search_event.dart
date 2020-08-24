import 'package:equatable/equatable.dart';
import 'package:tripadvisor/model/place.dart';

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

class PlacesUpdated extends FilteredSearchEvent {
  final List<Place> places;

  const PlacesUpdated(this.places);

  @override
  List<Object> get props => [places];

  @override
  String toString() => "PlacesUpdated { places: $places }";
}

class PlacesUpdating extends FilteredSearchEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => "PlacesUpdating";
}
