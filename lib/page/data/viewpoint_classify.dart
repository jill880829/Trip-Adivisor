import 'package:flutter/material.dart';

enum ViewpointClassify { Place, Eat, Hotel, Transport }

extension ViewpointExtension on ViewpointClassify {
  int get id {
    switch (this) {
      case ViewpointClassify.Place:
        return 0;
      case ViewpointClassify.Eat:
        return 1;
      case ViewpointClassify.Hotel:
        return 2;
      case ViewpointClassify.Transport:
        return 3;
    }
  }

  IconData get icon {
    switch (this) {
      case ViewpointClassify.Place:
        return Icons.place;
      case ViewpointClassify.Eat:
        return Icons.local_dining;
      case ViewpointClassify.Hotel:
        return Icons.local_hotel;
      case ViewpointClassify.Transport:
        return Icons.train;
    }
  }

  Color get color {
    switch (this) {
      case ViewpointClassify.Place:
        return Colors.red;
      case ViewpointClassify.Eat:
        return Colors.deepOrange;
      case ViewpointClassify.Hotel:
        return Colors.green;
      case ViewpointClassify.Transport:
        return Colors.blueAccent;
    }
  }

  String get type {
    switch (this) {
      case ViewpointClassify.Place:
        return 'tourist_attraction';
      case ViewpointClassify.Eat:
        return 'restaurant';
      case ViewpointClassify.Hotel:
        return 'lodging';
      case ViewpointClassify.Transport:
        return 'transit_station';
    }
  }
}
