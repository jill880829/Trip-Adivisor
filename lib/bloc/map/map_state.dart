import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

abstract class MapState extends Equatable {
  const MapState();
}

class MapInitial extends MapState {
  @override
  String toString() => 'MapInitial';

  @override
  List<Object> get props => [];
}

class MapLoadInProgress extends MapState {
  @override
  String toString() => 'MapLoadInProgress';

  @override
  List<Object> get props => [];
}

class MapLoadSuccess extends MapState {
  final Position position;

  const MapLoadSuccess(this.position);

  @override
  String toString() => 'MapLoadSuccess';

  @override
  List<Object> get props => [position];
}

class MapLoadFailure extends MapState {
  @override
  String toString() => 'MapLoadFailure';

  @override
  List<Object> get props => [];
}
