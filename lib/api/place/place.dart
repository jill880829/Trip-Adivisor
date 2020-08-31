import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';
import 'package:tripadvisor/model/place.dart';
import 'package:intl/intl.dart';
import '../google_apiKey.dart';
import 'package:tripadvisor/page/data/viewpoint_classify.dart';

class PlaceApiProvider {
  final Client _client;
  final String _apiKey = google_apiKey;
  final String _baseUrl = "maps.googleapis.com";
  final String _locale_language = Intl.getCurrentLocale();
  PlaceApiProvider({Client client}) : _client = client ?? Client();

  Future<List<Place>> findPlaceFromText({String query}) async {
    final response = await _client.get(Uri.https(
        _baseUrl, '/maps/api/place/findplacefromtext/json', {
      'key': _apiKey,
      'inputtype': 'textquery',
      'input': query,
      'language': _locale_language
    }));

    final List<String> placeIds = json
        .decode(response.body)['candidates']
        .map<String>((item) => item['place_id'].toString())
        .toList();

    List<Place> ret = [];
    for (var placeId in placeIds) ret.add(await details(placeId: placeId));
    return ret;
  }

  Future<List<Place>> nearBySearch(Location location, double radius) async {
    List<Place> ret = [];
    for (var e in ViewpointClassify.values) {
        var response = await _client
            .get(Uri.https(_baseUrl, '/maps/api/place/nearbysearch/json', {
          'key': _apiKey,
          'location': location.lat.toString() + ',' + location.lng.toString(),
          'radius': radius.toString(),
          'language': _locale_language,
          'type': e.type
        }));

        final List<Place> places = json
            .decode(response.body)['results']
            .map<Place>((item) => Place.fromJson(item))
            .toList();

        for (var place in places) {
          place.type = e.type;
          if (place.user_ratings_total.toString() != 'null') ret.add(place);
        }
    }

    ret.sort((a, b) => b.user_ratings_total.compareTo(a.user_ratings_total));
    return ret;
  }

  Future<List<Place>> autocomplete({String query, Location location}) async {
    final response = await _client
        .get(Uri.https(_baseUrl, '/maps/api/place/autocomplete/json', {
      'key': _apiKey,
      'language': _locale_language,
      'input': query,
      'location': location.lat.toString() + ',' + location.lng.toString(),
      'radius': '1',
    }));

    final List<String> placeIds = json
        .decode(response.body)['predictions']
        .map<String>((item) => item['place_id'].toString())
        .toList();

    List<Place> ret = [];
    for (var placeId in placeIds) ret.add(await details(placeId: placeId));
    return ret;
  }

  Future<Place> details({String placeId}) async {
    final response =
        await _client.get(Uri.https(_baseUrl, '/maps/api/place/details/json', {
      'key': _apiKey,
      'place_id': placeId,
      'fields': [
        'formatted_address',
        'formatted_phone_number',
        'geometry/location',
        'name',
        'photos',
        'place_id',
        'rating',
        'user_ratings_total',
        'types',
        'opening_hours/weekday_text',
        'review'
      ].join(','),
      'language': _locale_language
    }));

    return Place.fromJson(json.decode(response.body)['result']);
  }
}
