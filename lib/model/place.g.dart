// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Place _$PlaceFromJson(Map<String, dynamic> json) {
  return Place(
    json['formatted_address'] as String,
    json['formatted_phone_number'] as String,
    json['geometry'] == null
        ? null
        : Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
    json['name'] as String,
    (json['photos'] as List)
        ?.map(
            (e) => e == null ? null : Photo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['place_id'] as String,
    (json['rating'] as num)?.toDouble(),
    json['user_ratings_total'] as int,
    (json['types'] as List)?.map((e) => e as String)?.toList(),
    json['opening_hours'] == null
        ? null
        : OpeningHours.fromJson(json['opening_hours'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PlaceToJson(Place instance) => <String, dynamic>{
      'formatted_address': instance.formatted_address,
      'formatted_phone_number': instance.formatted_phone_number,
      'geometry': instance.geometry,
      'name': instance.name,
      'photos': instance.photos,
      'place_id': instance.place_id,
      'rating': instance.rating,
      'user_ratings_total': instance.user_ratings_total,
      'types': instance.types,
      'opening_hours': instance.opening_hours,
    };

Geometry _$GeometryFromJson(Map<String, dynamic> json) {
  return Geometry(
    json['location'] == null
        ? null
        : Location.fromJson(json['location'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GeometryToJson(Geometry instance) => <String, dynamic>{
      'location': instance.location,
    };

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
    (json['lat'] as num)?.toDouble(),
    (json['lng'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

Photo _$PhotoFromJson(Map<String, dynamic> json) {
  return Photo(
    (json['height'] as num)?.toDouble(),
    (json['width'] as num)?.toDouble(),
    json['photo_reference'] as String,
  );
}

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
      'height': instance.height,
      'width': instance.width,
      'photo_reference': instance.photo_reference,
    };

OpeningHours _$OpeningHoursFromJson(Map<String, dynamic> json) {
  return OpeningHours(
    (json['weekday_text'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$OpeningHoursToJson(OpeningHours instance) =>
    <String, dynamic>{
      'weekday_text': instance.weekday_text,
    };
