import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripadvisor/model/place.dart';
import 'package:tripadvisor/bloc/bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchInitialized extends SearchEvent {
  const SearchInitialized();

  @override
  List<Object> get props => [];

  @override
  String toString() => "SearchInitialized";
}

class SearchNearbyByPosition extends SearchEvent {
  final CameraPosition cameraPosition;
  final MapBloc mapBloc;

  const SearchNearbyByPosition(this.cameraPosition, this.mapBloc);

  @override
  List<Object> get props => [cameraPosition, mapBloc];

  @override
  String toString() =>
      "SearchNearbyByLocation { cameraPosition: $cameraPosition }";
}

class SearchNearbyByPlace extends SearchEvent {
  final Place place;
  final double radius;

  const SearchNearbyByPlace(this.place, this.radius);

  @override
  List<Object> get props => [place, radius];

  @override
  String toString() =>
      "SearchNearbyByLocation { place: $place, radius: $radius }";
}

class SearchSuggestionList extends SearchEvent {
  final String query;
  final Location location;

  const SearchSuggestionList(this.query, this.location);

  @override
  List<Object> get props => [query, location];

  @override
  String toString() =>
      "SearchTextOnChanged { query: $query, location: $location }";
}

class PivotUpdated extends SearchEvent {
  final Place pivot;

  const PivotUpdated(this.pivot);

  @override
  List<Object> get props => [pivot];

  @override
  String toString() => "PivotUpdated";
}
