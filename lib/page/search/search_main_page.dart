import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
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
          MyMap(),
          DraggableSearchableListView(),
        ],
      ),
    );
  }
}

class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  Completer<GoogleMapController> _controller = Completer();

  var currentLocation;

  @override
  void initState() {
    super.initState();
    Geolocator().getCurrentPosition().then((currloc) {
      setState(() {
        currentLocation = currloc;
        print(currentLocation.latitude);
      });
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller.complete(controller);
    });
  }

  Future<void> _moveToUserLocation() async {
    // print(currentLocation.latitude);
    // print(currentLocation.longitude);
    final GoogleMapController controller = await _controller.future;
    // await _getUserLocation();
    Geolocator().getCurrentPosition().then((currloc) {
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(currloc.latitude, currloc.longitude),
        zoom: 17.0,
      )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Trip Advisor'),
          backgroundColor: Colors.blue[700],
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target:
                    LatLng(currentLocation.latitude, currentLocation.longitude),
                zoom: 17.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: FloatingActionButton(
                  onPressed: _moveToUserLocation,
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  backgroundColor: Colors.blue,
                  child: const Icon(Icons.my_location, size: 36.0),
                ),
              ),
            ),
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
