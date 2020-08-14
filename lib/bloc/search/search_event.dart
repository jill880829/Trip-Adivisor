import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchOnSubmitted extends SearchEvent {
  final String query;

  const SearchOnSubmitted(this.query);

  @override
  List<Object> get props => [query];

  @override
  String toString() => "SearchOnSubmitted { query: $query }";
}