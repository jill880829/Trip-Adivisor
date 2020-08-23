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
  final OpeningHours opening_hours;
  final List<Review> reviews;

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
    this.opening_hours,
    this.reviews
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

@JsonSerializable()
class OpeningHours {
  final List<String> weekday_text;

  OpeningHours(this.weekday_text);

  factory OpeningHours.fromJson(Map<String, dynamic> json) =>
      _$OpeningHoursFromJson(json);

  Map<String, dynamic> toJson() => _$OpeningHoursToJson(this);
}

@JsonSerializable()
class Review {
  final String author_name;
  final String author_url;
  final String language;
  final String profile_photo_url;
  final int rating;
  final String relative_time_description;
  final String text;
  final int time;

  Review(this.author_name, this.author_url, this.language, this.profile_photo_url, this.rating, this.relative_time_description, this.text, this.time);

  factory Review.fromJson(Map<String, dynamic> json) =>
      _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
