import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tripadvisor/page/search/list/PlaceCard.dart';

import 'package:tripadvisor/bloc/bloc.dart';
import 'package:tripadvisor/model/place.dart';

class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  Completer<GoogleMapController> _controller = Completer();

  var currentLocation;

  final Set<Marker> _markers = {};

  List<Place> filterPlace(List<Place> places, List<String> show) {
    if (show.length == 0) return places;
    return places
        .where((place) => place.types.any((item) => show.contains(item)))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    Geolocator().getCurrentPosition().then((currloc) {
      setState(() {
        currentLocation = currloc;
        print(currentLocation.latitude);
      });
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller.complete(controller);
    });
  }

  Future<void> _moveToLocation(Place place) async {
    final GoogleMapController controller = await _controller.future;
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(place.geometry.location.lat, place.geometry.location.lng),
      zoom: 15.0,
    )));
  }

  LatLng _lastMapPosition;

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip Advisor'),
        backgroundColor: Colors.blue[700],
      ),
      body: Stack(
        children: <Widget>[
          BlocBuilder(
              bloc: BlocProvider.of<SearchBloc>(context),
              builder: (context, state) {
                if (state is SearchLoadSuccess) {
                  List<Place> filteredPlaces = filterPlace(
                    state.places,
                    BlocProvider.of<FilterBloc>(context).currentState.show,
                  );
                  _moveToLocation(filteredPlaces[0]);
                }
                return GoogleMap(
                  onMapCreated: _onMapCreated,
                  myLocationEnabled: true,
                  onCameraMove: _onCameraMove,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                        currentLocation.latitude, currentLocation.longitude),
                    zoom: 10.0,
                  ),
                  markers: _markers,
                );
              }),
        ],
      ),
    );
  }
}
