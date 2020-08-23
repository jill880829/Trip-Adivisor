import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';
import 'package:tripadvisor/model/place.dart';
import '../google_apiKey.dart';
import 'package:tripadvisor/page/data/viewpoint_classify.dart';

class PlaceApiProvider {
  final Client _client;
  final String _apiKey = google_apiKey;
  final String _baseUrl = "maps.googleapis.com";
  PlaceApiProvider({Client client}) : _client = client ?? Client();

  Future<List<Place>> findPlaceFromText({String query}) async {
    final response = await _client.get(Uri.https(
        _baseUrl, '/maps/api/place/findplacefromtext/json', {
      'key': _apiKey,
      'inputtype': 'textquery',
      'input': query,
      'language': 'zh-TW'
    }));

    final List<String> placeIds = json
        .decode(response.body)['candidates']
        .map<String>((item) => item['place_id'].toString())
        .toList();

    List<Place> ret = [];
    for (var placeId in placeIds) ret.add(await details(placeId: placeId));
    return ret;
  }

  Future<List<Place>> nearBySearch({double lat, double lng}) async {
    List<Place> ret = [];
    for (var e in ViewpointClassify.values) {
        var response = await _client
            .get(Uri.https(_baseUrl, '/maps/api/place/nearbysearch/json', {
          'key': _apiKey,
          'location': lat.toString() + ',' + lng.toString(),
          'rankby': 'distance',
          'language': 'zh-TW',
          'type': e.type
        }));

        final List<String> placeIds = json
            .decode(response.body)['results']
            .map<String>((item) => item['place_id'].toString())
            .toList();

        for (var placeId in placeIds) {
          final Place place = await details(placeId: placeId);
          if (place.user_ratings_total.toString() != 'null') ret.add(place);
        }
    }

    ret.sort((a, b) => b.user_ratings_total.compareTo(a.user_ratings_total));
    return ret;
  }

  Future<List<Place>> autocomplete({String query}) async {
    final response = await _client
        .get(Uri.https(_baseUrl, '/maps/api/place/autocomplete/json', {
      'key': _apiKey,
      'language': 'zh-TW',
      'input': query,
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
      'language': 'zh-TW'
    }));

    return Place.fromJson(json.decode(response.body)['result']);
  }
}
