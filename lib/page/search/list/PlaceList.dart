import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tripadvisor/page/search/list/PlaceCard.dart';

import 'package:tripadvisor/bloc/bloc.dart';
import 'package:tripadvisor/model/place.dart';

class PlaceList extends StatefulWidget {
  @override
  _PlaceListState createState() => _PlaceListState();
}

class _PlaceListState extends State<PlaceList> {
  List<Place> filterPlace(List<Place> places, List<String> show) {
    if (show.length == 0) return places;
    return places
        .where((place) => place.types.any((item) => show.contains(item)))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<SearchBloc>(context),
      builder: (context, state) {
        if (state is SearchLoadInProgress)
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        else if (state is SearchInitial)
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Center(
                child: Text('Init Search'),
              ),
            ),
          );
        else if (state is SearchLoadSuccess) {
          List<Place> filteredPlaces = filterPlace(
            state.places,
            BlocProvider.of<FilterBloc>(context).currentState.show,
          );
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, idx) => PlaceCard(
                place: filteredPlaces[idx],
              ),
              childCount: filteredPlaces.length,
            ),
          );
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
}
