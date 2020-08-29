import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripadvisor/bloc/filtered_search/filtered_search.dart';
import 'map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tripadvisor/model/place.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final FilteredSearchBloc filteredSearchBloc;
  StreamSubscription filteredSearchSubscription;
  MapBloc({@required this.filteredSearchBloc}) : super(MapInitial(null, {})) {
    filteredSearchSubscription =
        filteredSearchBloc.listen((filteredSearchState) {
      if (filteredSearchState is FilteredSearchLoadSuccess) {
        add(MapUpdated(filteredSearchState.pivot, filteredSearchState.nearby));
      }
    });
  }

  @override
  Stream<Transition<MapEvent, MapState>> transformEvents(
      Stream<MapEvent> events,
      Stream<Transition<MapEvent, MapState>> Function(
    MapEvent event,
  )
          transitionFn) {
    return events
        .debounceTime(const Duration(milliseconds: 300))
        .switchMap(transitionFn);
  }

  @override
  Stream<MapState> mapEventToState(
    MapEvent event,
  ) async* {
    if (event is MapUpdated) {
      yield* _mapMapUpdatedToState(event, state);
    } else if (event is MapMoving) {
      yield* _mapMapMovingToState(event, state);
    }
  }

  Stream<MapState> _mapMapMovingToState(
    MapMoving event,
    MapState state,
  ) async* {
    yield MapInMoving(event.cameraPosition, state.markers);
  }

  Stream<MapState> _mapMapUpdatedToState(
    MapUpdated event,
    MapState state,
  ) async* {
    CameraPosition cameraPosition;
    if (state.cameraPosition == null) {
      Position currentPosition = await Geolocator().getCurrentPosition();
      cameraPosition = CameraPosition(
        target: LatLng(currentPosition.latitude, currentPosition.longitude),
        zoom: 15,
      );
    } else {
      cameraPosition = state.cameraPosition;
    }
    yield MapLoadSuccess(
      _mapListToMarkerSet(event.pivot, event.nearby),
      cameraPosition,
    );
  }

  Set<Marker> _mapListToMarkerSet(Place pivot, List<Place> nearby) {
    Set<Marker> markers = {};
    for (final place in nearby) {
      double marker_color;
      if (place.type == 'tourist_attraction') {
        marker_color = BitmapDescriptor.hueRed;
      } else if (place.type == 'restaurant') {
        marker_color = BitmapDescriptor.hueOrange;
      } else if (place.type == 'lodging') {
        marker_color = BitmapDescriptor.hueGreen;
      } else if (place.type == 'transit_station') {
        marker_color = BitmapDescriptor.hueBlue;
      } else {
        marker_color = BitmapDescriptor.hueViolet;
      }
      markers.add(Marker(
        markerId: MarkerId(place.place_id),
        position:
            LatLng(place.geometry.location.lat, place.geometry.location.lng),
        infoWindow: InfoWindow(
          title: place.name,
          snippet: place.rating.toString(),
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(marker_color),
      ));
    }
    if (pivot != null) {
      markers.add(Marker(
        markerId: MarkerId(pivot.place_id),
        position:
            LatLng(pivot.geometry.location.lat, pivot.geometry.location.lng),
        infoWindow: InfoWindow(
          title: pivot.name,
          snippet: pivot.rating.toString(),
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    }
    return markers;
  }

  @override
  Future<void> close() {
    filteredSearchSubscription.cancel();
    return super.close();
  }
}
