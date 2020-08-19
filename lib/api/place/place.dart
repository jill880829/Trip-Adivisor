import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';
import 'package:tripadvisor/model/place.dart';
import '../google_apiKey.dart';

class PlaceApiProvider {
  final Client _client;
  final String _apiKey = google_apiKey;
  final String _baseUrl = "maps.googleapis.com";
  PlaceApiProvider({Client client}) : _client = client ?? Client();

  Future<List<Place>> findPlaceFromText({String query}) async {

    final response = await _client.get(
      Uri.https(
        _baseUrl, '/maps/api/place/findplacefromtext/json', {
          'key': _apiKey,
          'inputtype': 'textquery',
          'input': query,
          'language': 'zh-TW'
        }
      )
    );
    
    final List<String> placeIds = json
      .decode(response.body)['candidates']
      .map<String>( 
        (item) => item['place_id'].toString()
      ).toList();
    
    List<Place> ret = [];
    for (var placeId in placeIds)
      ret.add(await details(placeId: placeId));
    return ret;
  }

  Future<List<Place>> nearBySearch({double lat, double lng}) async {
    final response = await _client.get(
      Uri.https(
        _baseUrl, '/maps/api/place/nearbysearch/json', {
          'key': _apiKey,
          'location': lat.toString() + ',' + lng.toString(),
          'rankby': 'distance',
          'language': 'zh-TW'
        }
      )
    );

    final List<String> placeIds = json
      .decode(response.body)['results'].map<String>(
        (item) => item['place_id'].toString()
      ).toList();


    List<Place> ret = [];
    for (var placeId in placeIds)
      ret.add(await details(placeId: placeId));
    return ret;
  }

  Future<Place> details({String placeId}) async {
    final response = await _client.get(
      Uri.https(
        _baseUrl, '/maps/api/place/details/json', {
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
        }
      )
    );

    return Place.fromJson(json.decode(response.body)['result']);
  }
}