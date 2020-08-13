import 'package:flutter/material.dart';

enum ViewpointClassify { Place, Eat, Hotel, Transport, Favorite }

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
      case ViewpointClassify.Favorite:
        return 4;
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
      case ViewpointClassify.Favorite:
        return Icons.favorite;
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
      case ViewpointClassify.Favorite:
        return Colors.deepPurple;
    }
  }
}