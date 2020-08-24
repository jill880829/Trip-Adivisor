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
  @override
  Widget build(BuildContext context) {
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
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, idx) => PlaceCard(
                place: state.filteredPlaces[idx],
              ),
              childCount: state.filteredPlaces.length,
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
