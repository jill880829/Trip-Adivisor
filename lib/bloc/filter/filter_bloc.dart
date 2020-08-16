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
      yield* _mapFilteronPressedToState(currentState, event.index);
    }
  }
}

Stream<FilterState> _mapFilteronPressedToState(
  FilterState currentState,
  int index,
) async* {
  yield currentState.toggle(index);
}
