import 'package:json_annotation/json_annotation.dart';

import 'package:tripadvisor/api/google_apiKey.dart';

part 'place.g.dart';

@JsonSerializable()
class Place {
  // ignore: non_constant_identifier_names
  final String formatted_address;
  // ignore: non_constant_identifier_names
  final String formatted_phone_number;
  final Geometry geometry;
  final String name;
  final List<Photo> photos;
  // ignore: non_constant_identifier_names
  final String place_id;
  final double rating;
  // ignore: non_constant_identifier_names
  final int user_ratings_total;
  final List<String> types;
  Place(
    this.formatted_address,
    this.formatted_phone_number,
    this.geometry,
    this.name,
    this.photos,
    this.place_id,
    this.rating,
    this.user_ratings_total,
    this.types,
  );

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceToJson(this);
}

@JsonSerializable()
class Geometry {
  final Location location;
  Geometry(this.location);

  factory Geometry.fromJson(Map<String, dynamic> json) =>
      _$GeometryFromJson(json);

  Map<String, dynamic> toJson() => _$GeometryToJson(this);
}

@JsonSerializable()
class Location {
  final double lat;
  final double lng;
  Location(this.lat, this.lng);

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable()
class Photo {
  final double height;
  final double width;
  // ignore: non_constant_identifier_names
  final String photo_reference;
  Photo(this.height, this.width, this.photo_reference);

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoToJson(this);

  String toLink() =>
      "https://maps.googleapis.com/maps/api/place/photo?key=$google_apiKey&photoreference=$photo_reference&maxwidth=400";
}
