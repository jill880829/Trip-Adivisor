import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripadvisor/bloc/bloc.dart';
import 'search.dart';
import 'package:tripadvisor/api/place/place.dart';
import 'package:meta/meta.dart';
import 'package:tripadvisor/model/place.dart';
import 'package:rxdart/rxdart.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';

mixin SuggestionBloc on Bloc<SearchEvent, SearchState> {}

class SearchBloc extends Bloc<SearchEvent, SearchState> with SuggestionBloc {
  final PlaceApiProvider _placeApiProvider;

  SearchBloc({@required PlaceApiProvider placeApiProvider})
      : _placeApiProvider = placeApiProvider,
        super(SearchInitial());

  @override
  Stream<Transition<SearchEvent, SearchState>> transformEvents(
    Stream<SearchEvent> events,
    Stream<Transition<SearchEvent, SearchState>> Function(SearchEvent event)
        transitionFn,
  ) {
    return events
        .debounceTime(const Duration(milliseconds: 500))
        .switchMap(transitionFn);
  }

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchInitialized) {
      yield* _mapSearchInitializedToState(event, state);
    } else if (event is SearchNearbyByPosition) {
      if (state is SearchLoadSuccess)
        yield* _mapSearchNearbyByPositionToState(event, state);
    } else if (event is SearchNearbyByPlace) {
      yield* _mapSearchNearbyByPlaceToState(event, state);
    } else if (event is SearchSuggestionList) {
      yield* _mapSearchSuggestionListToState(event);
    }
  }

  Stream<SearchState> _mapSearchInitializedToState(
    SearchInitialized event,
    SearchInitial state,
  ) async* {
    yield SearchLoadInProgress();
    final Position currentPosition = await Geolocator().getCurrentPosition();
    final List<Place> nearby = await _placeApiProvider.nearBySearch(
      Location(
        currentPosition.latitude,
        currentPosition.longitude,
      ),
      1000,
    );
    yield SearchLoadSuccess(null, nearby, currentPosition);
  }

  Stream<SearchState> _mapSearchNearbyByPlaceToState(
    SearchNearbyByPlace event,
    SearchState state,
  ) async* {
    final Position currentPosition = await Geolocator().getCurrentPosition();
    final nearby = await _placeApiProvider.nearBySearch(
      event.place.geometry.location,
      event.radius,
    );
    yield SearchLoadSuccess(event.place, nearby, currentPosition);
  }

  Stream<SearchState> _mapSearchNearbyByPositionToState(
    SearchNearbyByPosition event,
    SearchLoadSuccess state,
  ) async* {
    yield SearchLoadInProgress();
    try {
      event.mapBloc.add(MapMoving(event.cameraPosition));
      final Position position = await Geolocator().getCurrentPosition();
      final nearby = await _placeApiProvider.nearBySearch(
        Location(
          event.cameraPosition.target.latitude,
          event.cameraPosition.target.longitude,
        ),
        3e7 / pow(2, event.cameraPosition.zoom),
      );
      yield SearchLoadSuccess(state.pivot, nearby, position);
    } catch (_) {
      print(_);
      yield SearchLoadFailure();
    }
  }

  Stream<SearchState> _mapSearchSuggestionListToState(
    SearchSuggestionList event,
  ) async* {
    yield SearchLoadInProgress();
    try {
      final Position position = await Geolocator().getCurrentPosition();
      final places = await _placeApiProvider.autocomplete(
        query: event.query,
        location: event.location,
      );
      if (places.length == 0) {
        yield SearchLoadFailure();
        return;
      }
      yield SearchLoadSuccess(null, places, position);
    } catch (_) {
      print(_);
      yield SearchLoadFailure();
    }
  }
}
