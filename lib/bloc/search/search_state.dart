import 'package:equatable/equatable.dart';
import 'package:tripadvisor/model/place.dart';
import 'package:geolocator/geolocator.dart';

mixin SuggestionState on Equatable {}

abstract class SearchState extends Equatable with SuggestionState {}

class SearchInitial extends SearchState {
  @override
  String toString() => 'SearchInitial';

  @override
  List<Object> get props => [];
}

class SearchLoadSuccess extends SearchState {
  final Place pivot;
  final List<Place> nearby;
  final Position currentPosition;

  SearchLoadSuccess(this.pivot, this.nearby, this.currentPosition);

  @override
  String toString() => 'SearchLoadSuccess';

  @override
  List<Object> get props => [pivot, nearby, currentPosition];
}

class SearchLoadInProgress extends SearchState {
  final Place pivot;

  SearchLoadInProgress(this.pivot);

  @override
  String toString() => 'SearchLoadInProgress';

  @override
  List<Object> get props => [pivot];
}

class SearchLoadFailure extends SearchState {
  @override
  String toString() => 'SearchLoadFailure';

  @override
  List<Object> get props => [];
}
