import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripadvisor/bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripadvisor/bloc/filtered_search/filtered_search.dart';
import 'map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tripadvisor/model/place.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;


class MapBloc extends Bloc<MapEvent, MapState> {
  final FilteredSearchBloc filteredSearchBloc;
  StreamSubscription filteredSearchSubscription;
  Map<String, BitmapDescriptor> place_icon = new Map<String,BitmapDescriptor>();

  MapBloc({@required this.filteredSearchBloc}) : super(MapInitial(null, {})) {
    setCustomMapMarker();
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
    } else if (event is MapMarkerTapping) {
      yield MapMarkerTapped(event.cameraPosition, state.markers, event.place);
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
      markers.add(Marker(
        markerId: MarkerId(place.place_id),
        position:
            LatLng(place.geometry.location.lat, place.geometry.location.lng),
        infoWindow: InfoWindow(
          title: place.name,
          snippet: place.rating.toString(),
        ),
        icon: place_icon[place.type],
        onTap: ()  {
          this.add(MapMarkerTapping(state.cameraPosition, place));
        },
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
        onTap: () {
          this.add(MapMarkerTapping(state.cameraPosition,pivot));
        },
      ));
    }
    return markers;
  }

  @override
  Future<void> close() {
    filteredSearchSubscription.cancel();
    return super.close();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }

  void setCustomMapMarker() async {
    final Uint8List place = await getBytesFromAsset('assets/images/icon_place.png', 70);
    final Uint8List eat = await getBytesFromAsset('assets/images/icon_eat.png', 70);
    final Uint8List hotel = await getBytesFromAsset('assets/images/icon_hotel.png', 70);
    final Uint8List bus = await getBytesFromAsset('assets/images/icon_bus.png', 70);

    place_icon["tourist_attraction"] = BitmapDescriptor.fromBytes(place);
    place_icon["restaurant"] = BitmapDescriptor.fromBytes(eat);
    place_icon["lodging"] = BitmapDescriptor.fromBytes(hotel);
    place_icon["transit_station"] = BitmapDescriptor.fromBytes(bus);
  }
}
