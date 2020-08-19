import 'dart:async';
import 'package:bloc/bloc.dart';
import 'draggable_listview.dart';
import 'package:tripadvisor/model/place.dart';

class DraggableListViewBloc
    extends Bloc<DraggableListViewEvent, DraggableListViewState> {
  @override
  DraggableListViewState get initialState => ShowSearch();

  @override
  Stream<DraggableListViewState> mapEventToState(
    DraggableListViewEvent event,
  ) async* {
    if (event is ChangeSearch) {
      yield ShowSearch();
    } else if (event is ChangeDetail) {
      yield* _showDetailState(event.place);
    }
  }

  Stream<DraggableListViewState> _showDetailState(Place place) async* {
    yield ShowDetailInProgress();

    if(place == null)
      yield ShowDetailFailure();
    else
      yield ShowDetailSuccess(place);
  }
}
