import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripadvisor/bloc/save_favorite/save_favorite_state.dart';

import 'package:tripadvisor/page/search/list/PlaceCard.dart';

import 'package:tripadvisor/bloc/bloc.dart';

class PlaceList extends StatefulWidget {
  @override
  _PlaceListState createState() => _PlaceListState();
}

class _PlaceListState extends State<PlaceList> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SaveFavoriteBloc>(context).add(InitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SaveFavoriteBloc, SaveFavoriteState>(
      builder: (show_context, show_state) {
        if (show_state is ShowFavoriteProgress) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (show_state is ShowFavoriteList) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, idx) => PlaceCard(
                place: show_state.places[idx],
              ),
              childCount: show_state.places.length,
            ),
          );
        } else if (show_state is ShowSearchList) {
          return BlocBuilder<FilteredSearchBloc, FilteredSearchState>(
            builder: (context, state) {
              if (state is FilteredSearchLoadInProgress)
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              else if (state is FilteredSearchLoadSuccess) {
                if (state.pivot != null) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, idx) => PlaceCard(
                        place: ([state.pivot] +
                            state.nearby
                                .where(
                                  (place) => place.name != state.pivot.name,
                                )
                                .toList())[idx],
                      ),
                      childCount: state.nearby
                              .where(
                                (place) => place.name != state.pivot.name,
                              )
                              .toList()
                              .length +
                          1,
                    ),
                  );
                } else {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, idx) => PlaceCard(
                        place: state.nearby[idx],
                      ),
                      childCount: state.nearby.length,
                    ),
                  );
                }
              }
              return SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Center(
                    child: Text('Loading Failed'),
                  ),
                ),
              );
            },
          );
        }
        return null;
      },
    );
  }
}
