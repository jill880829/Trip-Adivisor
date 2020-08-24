import 'dart:async';
import 'package:bloc/bloc.dart';
import 'map.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapInitial());

  @override
  Stream<MapState> mapEventToState(
    MapEvent event,
  ) async* {
    if (event is MapInitialize) {
      yield* _mapMapInitializeToState();
    }
  }

  Stream<MapState> _mapMapInitializeToState() async* {
    yield MapLoadInProgress();
  }
}
