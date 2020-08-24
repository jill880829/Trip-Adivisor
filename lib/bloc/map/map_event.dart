import 'package:equatable/equatable.dart';

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
