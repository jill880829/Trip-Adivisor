import 'package:equatable/equatable.dart';

class SearchEvent extends Equatable {
  SearchEvent([List props = const []]) : super(props);
}

class SearchOnSubmitted extends SearchEvent {
  final String query;

  SearchOnSubmitted({this.query}) : super([query]);

  @override
  String toString() => "SearchOnSubmitted { query: $query }";
}