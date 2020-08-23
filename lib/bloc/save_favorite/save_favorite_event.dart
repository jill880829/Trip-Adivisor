import 'package:equatable/equatable.dart';
import 'package:tripadvisor/model/place.dart';

abstract class SaveFavoriteEvent extends Equatable {
  const SaveFavoriteEvent();
}

class InitEvent extends SaveFavoriteEvent {
  const InitEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => "InitEvent";
}

class ChangeFavorite extends SaveFavoriteEvent {
  final String id;
  const ChangeFavorite(this.id);

  @override
  List<Object> get props => [id];

  @override
  String toString() => "ChangeFavorite { id: $id }";
}

class FavoriteOnPressed extends SaveFavoriteEvent {
  final bool search;
  const FavoriteOnPressed(this.search);

  @override
  List<Object> get props => [search];

  @override
  String toString() => "FilterOnPressed ";
}

class FavoriteRefresh extends SaveFavoriteEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => "FavoriteRefresh";
}