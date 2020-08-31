import 'package:json_annotation/json_annotation.dart';
import 'dart:math';
import 'package:tripadvisor/api/google_apiKey.dart';
import 'package:geolocator/geolocator.dart';

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
  String type;
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
      this.type,
      this.opening_hours,
      this.reviews);

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

  String toDistance(Location location) {
    double distance = calculateDistance(
      lat,
      lng,
      location.lat,
      location.lng,
    );
    if (distance < 1) {
      distance *= 1000;
      return distance.round().toString() + " m";
    } else {
      return distance.round().toString() + " km";
    }
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
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

  Review(
      this.author_name,
      this.author_url,
      this.language,
      this.profile_photo_url,
      this.rating,
      this.relative_time_description,
      this.text,
      this.time);

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
