import 'package:flutter/material.dart';
import 'package:tripadvisor/page/search/list/PlaceCard.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tripadvisor/bloc/search/search.dart';

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
                        preferredSize: const Size.fromHeight(40),
                        child: Column(
                          children: <Widget>[
                            TextField(
                              decoration: InputDecoration(
                                fillColor: Colors.black12,
                                filled: true,
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.search),
                                hintText: '請輸入地址 \\ 名稱'
                              ),
                              onSubmitted: (text) {
                                BlocProvider.of<SearchBloc>(context).dispatch(
                                  SearchOnSubmitted(query: text)
                                );
                              },
                              onChanged: (text) {
                                print ("text: " + text);
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
            }
          ),
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
              child: Center(child: CircularProgressIndicator())
            )
          );
        else if (state is SearchInitial)
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Center(child: Text('Init Search'))
            )
          );
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
            child: Center(child: Text('Loading Failed'))
          )
        );
      }
    );
  }
}

class FilterIcon extends StatefulWidget {
  FilterIcon({Key key}) : super(key: key);

  @override
  _FilterIconState createState() => _FilterIconState();
}

class _FilterIconState extends State<FilterIcon> {
  var showIcon = [false, false, false, false, false];
  var iconColor = [Colors.red, Colors.deepOrange, Colors.green, Colors.blueAccent, Colors.deepPurple];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: changeIcon(Icons.place, 0),
          onPressed: (){
            setState(() {
              showIcon[0] = !showIcon[0];
            });
          },
        ),
        IconButton(
          icon: changeIcon(Icons.local_dining, 1),
          onPressed: (){
            setState(() {
              showIcon[1] = !showIcon[1];
            });
          },
        ),
        IconButton(
          icon: changeIcon(Icons.local_hotel, 2),
          onPressed: (){
            setState(() {
              showIcon[2] = !showIcon[2];
            });
          },
        ),
        IconButton(
          icon: changeIcon(Icons.train, 3),
          onPressed: (){
            setState(() {
              showIcon[3] = !showIcon[3];
            });
          },
        ),
        IconButton(
          icon: changeIcon(Icons.favorite, 4),
          onPressed: (){
            setState(() {
              showIcon[4] = !showIcon[4];
            });
          },
        ),
      ],
    );
  }

  Widget changeIcon(IconData icon, int num){
    return (showIcon[num])?
        Icon(icon, color: iconColor[num],):Icon(icon, color: Colors.grey,);
  }
}
