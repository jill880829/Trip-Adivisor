import 'dart:async';
import 'package:bloc/bloc.dart';
import 'filter.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  @override
  FilterState get initialState => FilterState([]);

  @override
  Stream<FilterState> mapEventToState(
    FilterEvent event,
  ) async* {
    if (event is FilterOnPressed) {
      yield* _mapFilteronPressedToState(currentState, event.type);
    } else if (event is FilterClear) {
      yield* _clearAllFilter(currentState);
    }
  }
}

Stream<FilterState> _mapFilteronPressedToState(
  FilterState currentState,
  String type,
) async* {
  yield currentState.toggle(type);
}

Stream<FilterState> _clearAllFilter(FilterState currentState) async* {
  yield currentState.clear();
}