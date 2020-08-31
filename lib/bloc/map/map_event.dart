import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripadvisor/model/place.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class MapInitialize extends MapEvent {
  const MapInitialize();

  @override
  List<Object> get props => [];

  @override
  String toString() => "MapInitialize";
}

class MapUpdating extends MapEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => "MapUpdating";
}

class MapUpdated extends MapEvent {
  final Place pivot;
  final List<Place> nearby;
  const MapUpdated(this.pivot, this.nearby);

  @override
  List<Object> get props => [];

  @override
  String toString() => "MapUpdated";
}

class MapMoving extends MapEvent {
  final CameraPosition cameraPosition;

  const MapMoving(this.cameraPosition);

  @override
  List<Object> get props => [];

  @override
  String toString() => "MapMoving";
}

class MapMarkerTapping extends MapEvent {
  final CameraPosition cameraPosition;
  final Place place;

  const MapMarkerTapping(this.cameraPosition, this.place);

  @override
  List<Object> get props => [place];

  @override
  String toString() => "MapMarkerTapping";
}

class MarkerSuccess extends MapEvent {
  final CameraPosition cameraPosition;

  const MarkerSuccess(this.cameraPosition);

  @override
  List<Object> get props => [];

  @override
  String toString() => "MarkerSuccess";
}