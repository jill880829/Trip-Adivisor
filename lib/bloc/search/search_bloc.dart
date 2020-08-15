import 'dart:async';
import 'package:bloc/bloc.dart';
import 'search.dart';
import 'package:tripadvisor/api/place/place.dart';
import 'package:meta/meta.dart';
import 'package:tripadvisor/model/place.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final PlaceApiProvider _placeApiProvider;

  SearchBloc({@required PlaceApiProvider placeApiProvider})
      : assert(placeApiProvider != null),
        _placeApiProvider = placeApiProvider;

  @override
  SearchState get initialState => SearchInitial();

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchOnSubmitted) {
      yield* _mapSearchOnSubmittedToState(event.query);
    }
  }

  Stream<SearchState> _mapSearchOnSubmittedToState(String query) async* {
    yield SearchLoadInProgress();
    try {
      final places = await _placeApiProvider.findPlaceFromText(query: query);
      if (places.length == 0) {
        yield SearchLoadFailure();
        return;
      }

      List<Place> nearPlaces = (await _placeApiProvider.nearBySearch(
              lat: places[0].geometry.location.lat,
              lng: places[0].geometry.location.lng))
          .where((element) => element.rating.toString() != 'null')
          .toList()
          .where((element) => element.user_ratings_total.toString() != 'null')
          .toList()
          .where((element) => element.place_id != places[0].place_id)
          .toList();

      nearPlaces
          .sort((a, b) => b.user_ratings_total.compareTo(a.user_ratings_total));

      yield SearchLoadSuccess([places[0]] + nearPlaces);
    } catch (_) {
      print(_);
      yield SearchLoadFailure();
    }
  }
}
