import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:tripadvisor/bloc/bloc.dart';

import 'package:tripadvisor/model/place.dart';

class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  GoogleMapController _controller;

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  void _moveToPosition(CameraPosition cameraPosition) {
    _controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, mapState) {
        if (mapState is MapInitial) return Column();
        if (mapState is MapInMoving) _moveToPosition(mapState.cameraPosition);
        return GoogleMap(
          onMapCreated: _onMapCreated,
          myLocationEnabled: true,
          initialCameraPosition: mapState.cameraPosition,
          markers: mapState.markers,
          onCameraMove: (position) {
            if (mapState is MapLoadSuccess) {
              BlocProvider.of<MapBloc>(context).add(MapMoving(position));
              final LatLng target = position.target;
              final double zoom = position.zoom;
              BlocProvider.of<SearchBloc>(context).add(
                SearchNearbyByLocation(
                  Location(target.latitude, target.longitude),
                  3e7 / pow(2, zoom),
                ),
              );
            }
          },
        );
      },
    );
  }
}
