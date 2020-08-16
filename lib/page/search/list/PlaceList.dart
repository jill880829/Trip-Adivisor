import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tripadvisor/page/search/list/PlaceCard.dart';

import 'package:tripadvisor/bloc/search/search.dart';

class PlaceList extends StatefulWidget {
  @override
  _PlaceListState createState() => _PlaceListState();
}

class _PlaceListState extends State<PlaceList> {
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
        else if (state is SearchLoadSuccess)
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, idx) => PlaceCard(
                place: state.places[idx],
              ),
              childCount: state.places.length,
            ),
          );
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
