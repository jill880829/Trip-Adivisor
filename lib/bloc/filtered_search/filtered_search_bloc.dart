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
    searchSubscription = searchBloc.listen((searchState) {
      if (searchState is SearchLoadInProgress) {
        add(FilteredSearchUpdating());
      } else if (searchState is SearchLoadSuccess) {
        add(FilteredSearchUpdated(
          searchState.pivot,
          searchState.nearby,
          searchState.currentPosition,
          state.activeFilter,
        ));
      }
    });
  }

  @override
  Stream<FilteredSearchState> mapEventToState(
    FilteredSearchEvent event,
  ) async* {
    if (event is FilterUpdated) {
      yield* _mapFilterUpdatedToState(event, state);
    } else if (event is FilteredSearchUpdating) {
      yield* _mapFilteredSearchUpdatingToState(event);
    } else if (event is FilteredSearchUpdated) {
      yield* _mapFilteredSearchUpdatedToState(event);
    } else if (event is FilterClear) {
      yield* _mapFilterClearToState(event, state);
    }
  }

  Stream<FilteredSearchState> _mapFilterClearToState(
    FilterClear event,
    FilteredSearchLoadSuccess state,
  ) async* {
    yield FilteredSearchLoadInProgress(List<String>());
    yield FilteredSearchLoadSuccess(
      state.pivot,
      state.nearby,
      state.currentPosition,
      List<String>(),
    );
  }

  Stream<FilteredSearchState> _mapFilterUpdatedToState(
    FilterUpdated event,
    FilteredSearchState state,
  ) async* {
    yield FilteredSearchLoadInProgress(state.activeFilter);
    if (searchBloc.state is SearchLoadSuccess) {
      final List<String> newActivedFilter =
          state.activeFilter.contains(event.type)
              ? state.activeFilter
                  .where((element) => element != event.type)
                  .toList()
              : state.activeFilter + [event.type];
      yield FilteredSearchLoadSuccess(
        (searchBloc.state as SearchLoadSuccess).pivot,
        _mapPlacesToFilteredPlaces(
          (searchBloc.state as SearchLoadSuccess).nearby,
          newActivedFilter,
        ),
        (searchBloc.state as SearchLoadSuccess).currentPosition,
        newActivedFilter,
      );
    }
  }

  Stream<FilteredSearchState> _mapFilteredSearchUpdatingToState(
    FilteredSearchEvent event,
  ) async* {
    yield FilteredSearchLoadInProgress(state.activeFilter);
  }

  Stream<FilteredSearchState> _mapFilteredSearchUpdatedToState(
    FilteredSearchEvent event,
  ) async* {
    if (searchBloc.state is SearchLoadSuccess) {
      yield FilteredSearchLoadSuccess(
        (searchBloc.state as SearchLoadSuccess).pivot,
        _mapPlacesToFilteredPlaces(
          (searchBloc.state as SearchLoadSuccess).nearby,
          state.activeFilter,
        ),
        (searchBloc.state as SearchLoadSuccess).currentPosition,
        state.activeFilter,
      );
    }
  }

  List<Place> _mapPlacesToFilteredPlaces(
    List<Place> nearBy,
    List<String> activeFilter,
  ) {
    if (activeFilter.length == 0) return nearBy;
    return nearBy.where((place) => activeFilter.contains(place.type)).toList();
  }

  @override
  Future<void> close() {
    searchSubscription.cancel();
    return super.close();
  }
}
