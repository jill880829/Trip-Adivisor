import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:tripadvisor/bloc/save_favorite/save_favorite.dart';
import 'save_favorite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripadvisor/api/place/place.dart';
import 'package:tripadvisor/model/place.dart';
import 'package:meta/meta.dart';

class SaveFavoriteBloc extends Bloc<SaveFavoriteEvent, SaveFavoriteState> {
  final PlaceApiProvider _placeApiProvider;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final String _share_key = "favorite_list";
  List<String> _list;
  bool _isSearch = true;

  List<String> get getList => _list;
  bool get getIsSearch => _isSearch;

  SaveFavoriteBloc({@required PlaceApiProvider placeApiProvider})
      : assert(placeApiProvider != null),
        _placeApiProvider = placeApiProvider;

  @override
  SaveFavoriteState get initialState => ShowSearchList();

  @override
  Stream<SaveFavoriteState> mapEventToState(SaveFavoriteEvent event) async* {
    if (event is InitEvent) {
      yield* _init();
    } else if (event is ChangeFavorite) {
      yield* _changeFavoriteState(event.id);
    } else if (event is FavoriteOnPressed) {
      yield* _showFavoriteState(event.search);
    } else if (event is FavoriteRefresh) {
      yield* _refreshState();
    }
  }

  Stream<SaveFavoriteState> _init() async* {
    final SharedPreferences prefs = await _prefs;
    _list = prefs.getStringList(_share_key) ?? new List<String>();

    ShowSearchList();
  }

  Stream<SaveFavoriteState> _changeFavoriteState(String id) async* {
    final SharedPreferences prefs = await _prefs;
    List<String> list = prefs.getStringList(_share_key) ?? new List<String>();

    if (list.contains(id)) {
      list.remove(id);
    } else {
      list.add(id);
    }

    prefs.setStringList(_share_key, list);
    _list = list;
  }

  Stream<SaveFavoriteState> _showFavoriteState(bool search) async* {
    if (!search) {
      if (_isSearch) {
        yield ShowFavoriteProgress();
        try {
          List<Place> places = new List<Place>();
          for (var id in _list)
            places.add(await _placeApiProvider.details(placeId: id));

          yield ShowFavoriteList(places);
        } catch (_) {
          print(_);
        }
      }
    } else {
      if (!_isSearch) {
        yield ShowSearchList();
      }
    }

    _isSearch = search;
  }

  Stream<SaveFavoriteState> _refreshState() async* {
    yield ShowFavoriteProgress();

    List<Place> places = new List<Place>();
    for (var id in _list)
      places.add(await _placeApiProvider.details(placeId: id));

    yield ShowFavoriteList(places);
  }

  bool isContain (String id) {
    print("aaaaaaaaaaaaaaaaaaaaaaaaaa");
    return getList.contains(id);
  }
}
