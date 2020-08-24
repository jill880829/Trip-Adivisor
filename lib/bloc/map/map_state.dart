import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripadvisor/model/place.dart';

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
  final GoogleMapController controller;

  const MapLoadSuccess(this.controller);

  @override
  String toString() => 'MapLoadSuccess';

  @override
  List<Object> get props => [controller];
}

class MapLoadFailure extends MapState {
  @override
  String toString() => 'MapLoadFailure';

  @override
  List<Object> get props => [];
}
