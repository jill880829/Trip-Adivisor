import 'package:flutter/material.dart';

import 'package:tripadvisor/page/search/list/DraggableSearchableListView.dart';
import 'package:tripadvisor/page/search/map/map.dart';

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
          MyMap(),
          DraggableSearchableListView(),
        ],
      )
    );
  }
}
