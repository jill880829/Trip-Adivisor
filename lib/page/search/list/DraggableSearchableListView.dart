import 'package:flutter/material.dart';
import 'package:tripadvisor/page/search/list/PlaceList.dart';
import 'package:tripadvisor/generated/l10n.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tripadvisor/bloc/search/search.dart';
import 'package:tripadvisor/page/data/viewpoint_classify.dart';
import 'package:tripadvisor/page/search/list/Filter.dart';

class DraggableSearchableListView extends StatefulWidget {
  DraggableSearchableListView({Key key}) : super(key: key);

  @override
  _DraggableSearchableListViewState createState() =>
      _DraggableSearchableListViewState();
}

class _DraggableSearchableListViewState
    extends State<DraggableSearchableListView> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableActuator(
      child: Stack(
        children: <Widget>[
          DraggableScrollableSheet(
            initialChildSize: 0.18,
            minChildSize: 0.18,
            maxChildSize: 0.85,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: <Widget>[
                    SliverAppBar(
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(45),
                        child: Column(
                          children: <Widget>[
                            TextField(
                              decoration: InputDecoration(
                                fillColor: Colors.black12,
                                filled: true,
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.search),
                                hintText: S.of(context).search_hint,
                              ),
                              onSubmitted: (text) =>
                                  BlocProvider.of<SearchBloc>(context)
                                      .dispatch(SearchOnSubmitted(text)),
                            ),
                            Filter(),
                          ],
                        ),
                      ),
                      backgroundColor: Colors.white,
                      pinned: true,
                    ),
                    PlaceList(),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
