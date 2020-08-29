import 'dart:async';
import 'package:bloc/bloc.dart';
import 'draggable_listview.dart';
import 'package:tripadvisor/model/place.dart';
import 'package:tripadvisor/api/place/place.dart';
import 'package:meta/meta.dart';

class DraggableListViewBloc
    extends Bloc<DraggableListViewEvent, DraggableListViewState> {
  final PlaceApiProvider _placeApiProvider;
  DraggableListViewBloc({@required PlaceApiProvider placeApiProvider})
      : assert(placeApiProvider != null),
        _placeApiProvider = placeApiProvider,
        super(ShowSearch());

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

    if (place == null)
      yield ShowDetailFailure();
    else
      yield ShowDetailSuccess(
          await _placeApiProvider.details(placeId: place.place_id));
  }
}
