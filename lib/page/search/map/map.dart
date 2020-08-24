import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'package:tripadvisor/bloc/bloc.dart';
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

  Set<Marker> _markers = {};

  @override
  void initState() {
    BlocProvider.of<MapBloc>(context).add(MapInitialize());
    super.initState();
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

  void _addMarker(List<Place> place_list) {
    _markers.clear();
    for (final place in place_list) {
      double marker_color;
      if (place.types.any((item) => (item == 'tourist_attraction'))) {
        marker_color = BitmapDescriptor.hueRed;
      } else if (place.types.any((item) => (item == 'restaurant'))) {
        marker_color = BitmapDescriptor.hueOrange;
      } else if (place.types.any((item) => (item == 'lodging'))) {
        marker_color = BitmapDescriptor.hueGreen;
      } else if (place.types.any((item) => (item == 'transit_station'))) {
        marker_color = BitmapDescriptor.hueBlue;
      } else {
        marker_color = BitmapDescriptor.hueViolet;
      }
      _markers.add(Marker(
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
          BlocBuilder<FilteredSearchBloc, FilteredSearchState>(
              builder: (context, state) {
            if (state is FilteredSearchLoadSuccess) {
              if (state.filteredPlaces.length != 0)
                _moveToLocation(state.filteredPlaces[0]);
              _addMarker(state.filteredPlaces);
            }
            return GoogleMap(
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(23, 120),
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
