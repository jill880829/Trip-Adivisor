import 'package:flutter/material.dart';
import 'package:tripadvisor/bloc/bloc.dart';
import 'package:tripadvisor/page/search/list/PlaceCard.dart';
import 'package:tripadvisor/page/search/list/PlaceDetail.dart';
import 'package:tripadvisor/generated/l10n.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tripadvisor/bloc/search/search.dart';
import 'package:tripadvisor/page/data/viewpoint_classify.dart';

class DraggableSearchableListView extends StatefulWidget {
  DraggableSearchableListView({Key key}) : super(key: key);

  @override
  _DraggableSearchableListViewState createState() =>
      _DraggableSearchableListViewState();
}

class _DraggableSearchableListViewState
    extends State<DraggableSearchableListView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableActuator(
      child: Stack(
        children: <Widget>[
          DraggableScrollableSheet(
              initialChildSize: 0.18,
              minChildSize: 0.18,
              maxChildSize: 0.85,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return BlocBuilder(
                    bloc: BlocProvider.of<DraggableListViewBloc>(context),
                    builder: (context, state) {
                      if (state is ShowSearch)
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
                                          onSubmitted: (text) {
                                            BlocProvider.of<SearchBloc>(context)
                                                .dispatch(
                                                    SearchOnSubmitted(text));
                                          },
                                          onChanged: (text) {
                                            print("text: " + text);
                                          }),
                                      FilterIcon(),
                                    ],
                                  ),
                                ),
                                backgroundColor: Colors.white,
                                pinned: true,
                              ),
                              PlaceList()
                            ],
                          ),
                        );
                      else if (state is ShowDetailSuccess)
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  flex: 8,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(height: 15,),
                                      Text(state.place.name, style: TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.bold)),
                                      Text(state.place.formatted_address),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: IconButton(
                                    icon: Icon(Icons.clear),
                                    onPressed: (){
                                      BlocProvider.of<DraggableListViewBloc>(context)
                                          .dispatch(ChangeSearch());
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );

                      return Container(
                        child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Center(child: Text('Loading Failed'))),
                      );
                    });
              }),
        ],
      ),
    );
  }
}

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
                    child: Center(child: CircularProgressIndicator())));
          else if (state is SearchInitial)
            return SliverToBoxAdapter(
                child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Center(child: Text('Init Search'))));
          else if (state is SearchLoadSuccess)
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, idx) => PlaceCard(place: state.places[idx]),
                childCount: state.places.length,
              ),
            );
          return SliverToBoxAdapter(
              child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Center(child: Text('Loading Failed'))));
        });
  }
}

class FilterIcon extends StatefulWidget {
  FilterIcon({Key key}) : super(key: key);

  @override
  _FilterIconState createState() => _FilterIconState();
}

class _FilterIconState extends State<FilterIcon> {
  var showIcon = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: changeIcon(ViewpointClassify.Place),
          onPressed: () {
            setState(() {
              showIcon[0] = !showIcon[0];
            });
          },
        ),
        IconButton(
          icon: changeIcon(ViewpointClassify.Eat),
          onPressed: () {
            setState(() {
              showIcon[1] = !showIcon[1];
            });
          },
        ),
        IconButton(
          icon: changeIcon(ViewpointClassify.Hotel),
          onPressed: () {
            setState(() {
              showIcon[2] = !showIcon[2];
            });
          },
        ),
        IconButton(
          icon: changeIcon(ViewpointClassify.Transport),
          onPressed: () {
            setState(() {
              showIcon[3] = !showIcon[3];
            });
          },
        ),
        IconButton(
          icon: changeIcon(ViewpointClassify.Favorite),
          onPressed: () {
            setState(() {
              showIcon[4] = !showIcon[4];
            });
          },
        ),
      ],
    );
  }

  Widget changeIcon(ViewpointClassify classify) {
    return (showIcon[classify.id])
        ? Icon(
            classify.icon,
            color: classify.color,
          )
        : Icon(
            classify.icon,
            color: Colors.grey,
          );
  }
}
