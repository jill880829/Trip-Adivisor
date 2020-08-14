import 'package:equatable/equatable.dart';
import 'package:tripadvisor/model/place.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitial extends SearchState {

  @override
  String toString() => 'SearchInitial';

  @override
  List<Object> get props => [];
}

class SearchLoadInProgress extends SearchState {
  @override
  String toString() => 'SearchLoadInProgress';

  @override
  List<Object> get props => [];
}

class SearchLoadSuccess extends SearchState {
  final List<Place> places;

  const SearchLoadSuccess(this.places);

  @override
  String toString() => 'SearchLoadSuccess';

  @override
  List<Object> get props => [places];
}

class SearchLoadFailure extends SearchState {
  @override
  String toString() => 'SearchLoadFailure';

  @override
  List<Object> get props => [];
}