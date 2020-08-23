import 'package:equatable/equatable.dart';
import 'package:tripadvisor/model/place.dart';

abstract class SaveFavoriteState extends Equatable {
  const SaveFavoriteState();

  @override
  List<Object> get props => [];
}

class ShowFavoriteProgress extends SaveFavoriteState {
  @override
  String toString() => 'ShowFavoriteProgress';

  @override
  List<Object> get props => [];
}

class ShowFavoriteList extends SaveFavoriteState {
  final List<Place> places;

  const ShowFavoriteList(this.places);

  @override
  String toString() => 'ShowFavoriteList';

  @override
  List<Object> get props => [places];
}

class ShowSearchList extends SaveFavoriteState {
  const ShowSearchList();

  @override
  String toString() => 'ShowSearchList';

  @override
  List<Object> get props => [];
}