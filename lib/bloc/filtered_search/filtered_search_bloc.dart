import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:tripadvisor/bloc/bloc.dart';
import 'filtered_search.dart';
import 'package:tripadvisor/model/place.dart';

class FilteredSearchBloc
    extends Bloc<FilteredSearchEvent, FilteredSearchState> {
  final SearchBloc searchBloc;
  StreamSubscription searchSubscription;

  FilteredSearchBloc({@required this.searchBloc})
      : super(FilteredSearchInitial()) {
    searchSubscription = searchBloc.listen((state) {
      if (state is SearchLoadInProgress) {
        add(PlacesUpdating());
      } else if (state is SearchLoadSuccess) {
        add(PlacesUpdated((searchBloc.state as SearchLoadSuccess).places));
      }
    });
  }

  @override
  Stream<FilteredSearchState> mapEventToState(
    FilteredSearchEvent event,
  ) async* {
    if (event is FilterUpdated) {
      yield* _mapFilterUpdatedToState(event.type);
    } else if (event is PlacesUpdating) {
      yield* _mapPlacesUpdatingToState(event);
    } else if (event is PlacesUpdated) {
      yield* _mapPlacesUpdatedToState(event);
    }
  }

  Stream<FilteredSearchState> _mapFilterUpdatedToState(
    String type,
  ) async* {
    if (searchBloc.state is SearchLoadSuccess) {
      final List<String> newActivedFilter = state.activeFilter.contains(type)
          ? state.activeFilter.where((element) => element != type).toList()
          : state.activeFilter + [type];
      yield FilteredSearchLoadSuccess(
        _mapPlacesToFilteredPlaces(
          (searchBloc.state as SearchLoadSuccess).places,
          newActivedFilter,
        ),
        newActivedFilter,
      );
    }
  }

  Stream<FilteredSearchState> _mapPlacesUpdatingToState(
    FilteredSearchEvent event,
  ) async* {
    yield FilteredSearchLoadInProgress(state.activeFilter);
  }

  Stream<FilteredSearchState> _mapPlacesUpdatedToState(
    FilteredSearchEvent event,
  ) async* {
    yield FilteredSearchLoadSuccess(
      _mapPlacesToFilteredPlaces(
        (searchBloc.state as SearchLoadSuccess).places,
        state.activeFilter,
      ),
      state.activeFilter,
    );
  }

  List<Place> _mapPlacesToFilteredPlaces(
    List<Place> places,
    List<String> activeFilter,
  ) {
    if (activeFilter.length == 0) return places;
    return places.where((place) {
      if (activeFilter.length == 0) {
        return true;
      } else {
        return place.types.any((item) => activeFilter.contains(item));
      }
    }).toList();
  }

  @override
  Future<void> close() {
    searchSubscription.cancel();
    return super.close();
  }
}
