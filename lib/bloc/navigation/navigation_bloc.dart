import 'dart:async';
import 'package:bloc/bloc.dart';
import 'navigation.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  @override
  NavigationState get initialState => NavigationSearch();

  @override
  Stream<NavigationState> mapEventToState(
    NavigationEvent event,
  ) async* {
    if (event is NavigationOnTap) {
      yield* _mapNavigationOnTapToState(event.index);
    }
  }
}

Stream<NavigationState> _mapNavigationOnTapToState(int index) async* {
  switch (index) {
    case 0:
      yield NavigationSearch();
      break;
    case 1:
      yield NavigationSchedule();
      break;
    case 2:
      yield NavigationAccount();
      break;
    default:
      yield NavigationError();
      break;
  }
}
