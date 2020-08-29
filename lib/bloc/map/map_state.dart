import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapState extends Equatable {
  final CameraPosition cameraPosition;
  final Set<Marker> markers;
  const MapState(this.cameraPosition, this.markers);
}

class MapInitial extends MapState {
  MapInitial(CameraPosition cameraPosition, Set<Marker> markers)
      : super(cameraPosition, markers);

  @override
  String toString() => 'MapInitial';

  @override
  List<Object> get props => [];
}

class MapInMoving extends MapState {
  MapInMoving(CameraPosition cameraPosition, Set<Marker> markers)
      : super(cameraPosition, markers);

  @override
  String toString() => 'MapMoving';

  @override
  List<Object> get props => [];
}

class MapLoadSuccess extends MapState {
  const MapLoadSuccess(Set<Marker> markers, CameraPosition cameraPosition)
      : super(cameraPosition, markers);

  @override
  String toString() => 'MapLoadSuccess';

  @override
  List<Object> get props => [markers];
}

class MapLoadFailure extends MapState {
  MapLoadFailure(CameraPosition cameraPosition, Set<Marker> markers)
      : super(cameraPosition, markers);

  @override
  String toString() => 'MapLoadFailure';

  @override
  List<Object> get props => [];
}
