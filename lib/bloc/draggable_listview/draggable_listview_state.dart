import 'package:equatable/equatable.dart';
import 'package:tripadvisor/model/place.dart';

abstract class DraggableListViewState extends Equatable {
  const DraggableListViewState();
}

class ShowSearch extends DraggableListViewState {
  @override
  String toString() => 'ShowSearch';

  @override
  List<Object> get props => [];
}

class ShowDetailInProgress extends DraggableListViewState {
  @override
  String toString() => 'ShowDetailInProgress';

  @override
  List<Object> get props => [];
}

class ShowDetailSuccess extends DraggableListViewState {
  final Place place;

  const ShowDetailSuccess(this.place);

  @override
  String toString() => 'ShowDetailSuccess';

  @override
  List<Object> get props => [place];
}

class ShowDetailFailure extends DraggableListViewState {
  @override
  String toString() => 'ShowDetailFailure';

  @override
  List<Object> get props => [];
}