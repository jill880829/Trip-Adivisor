import 'package:equatable/equatable.dart';
import 'package:tripadvisor/model/place.dart';

abstract class DraggableListViewEvent extends Equatable {
  const DraggableListViewEvent();
}

class ChangeSearch extends DraggableListViewEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => "ChangeSearch";
}

class ChangeDetail extends DraggableListViewEvent {
  final Place place;

  const ChangeDetail(this.place);

  @override
  List<Object> get props => [place];

  @override
  String toString() => "ChangeDetail { place: $place }";
}