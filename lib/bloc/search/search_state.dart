import 'package:equatable/equatable.dart';
import 'package:tripadvisor/model/place.dart';

abstract class SearchState extends Equatable {
  SearchState([List props = const []]) : super(props);
}

class SearchInitial extends SearchState {
  @override
  String toString() => 'SearchInitial';
}

class SearchLoadInProgress extends SearchState {
  @override
  String toString() => 'SearchLoadInProgress';
}

class SearchLoadSuccess extends SearchState {
  final List<Place> places;

  SearchLoadSuccess(this.places) : super([places]);

  @override
  String toString() => 'SearchLoadSuccess';
}

class SearchLoadFailure extends SearchState {
  @override
  String toString() => 'SearchLoadFailure';
}