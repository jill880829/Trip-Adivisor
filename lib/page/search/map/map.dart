import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'package:tripadvisor/bloc/bloc.dart';

class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  Completer<GoogleMapController> _controller = Completer();

  var currentLocation;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MapBloc>(context).add(MapInitialize());
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller.complete(controller);
    });
  }

  Future<void> _moveToUserLocation() async {
    // print(currentLocation.latitude);
    // print(currentLocation.longitude);
    final GoogleMapController controller = await _controller.future;
    // await _getUserLocation();
    Geolocator().getCurrentPosition().then((currloc) {
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(currloc.latitude, currloc.longitude),
        zoom: 17.0,
      )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip Advisor'),
        backgroundColor: Colors.blue[700],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          zoom: 17.0,
        ),
      ),
    );
  }
}
