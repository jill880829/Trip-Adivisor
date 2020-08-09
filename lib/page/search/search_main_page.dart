import 'package:flutter/material.dart';
import 'package:tripadvisor/page/search/place_card.dart';
import 'package:tripadvisor/generated/l10n.dart';
import 'package:tripadvisor/page/data/viewpoint_classify.dart';

// Main page for searching, including map and search list.
class SearchMain extends StatefulWidget {
  SearchMain({Key key}) : super(key: key);

  @override
  _SearchMainState createState() => _SearchMainState();
}

class _SearchMainState extends State<SearchMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //TODO:  Show map here.
          DraggableSearchableListView(),
        ],
      ),
    );
  }
}

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
              builder:
                  (BuildContext context, ScrollController scrollController) {
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
                                    hintText: S.of(context).search_hint),
                              ),
                              FilterIcon(),
                            ],
                          ),
                        ),
                        backgroundColor: Colors.white,
                        pinned: true,
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, idx) => PlaceCard(),
                          childCount: 10,
                        ),
                      )
                    ],
                  ),
                );
              }),
        ],
      ),
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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: changeIcon(ViewpointClassify.Place),
          onPressed: (){
            setState(() {
              showIcon[0] = !showIcon[0];
            });
          },
        ),
        IconButton(
          icon: changeIcon(ViewpointClassify.Eat),
          onPressed: (){
            setState(() {
              showIcon[1] = !showIcon[1];
            });
          },
        ),
        IconButton(
          icon: changeIcon(ViewpointClassify.Hotel),
          onPressed: (){
            setState(() {
              showIcon[2] = !showIcon[2];
            });
          },
        ),
        IconButton(
          icon: changeIcon(ViewpointClassify.Transport),
          onPressed: (){
            setState(() {
              showIcon[3] = !showIcon[3];
            });
          },
        ),
        IconButton(
          icon: changeIcon(ViewpointClassify.Favorite),
          onPressed: (){
            setState(() {
              showIcon[4] = !showIcon[4];
            });
          },
        ),
      ],
    );
  }

  Widget changeIcon(ViewpointClassify classify){
    return (showIcon[classify.id])?
        Icon(classify.icon, color:classify.color,):Icon(classify.icon, color: Colors.grey,);
  }
}
