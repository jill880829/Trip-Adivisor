import 'package:flutter/material.dart';
import 'package:tripadvisor/model/place.dart';
import 'package:tripadvisor/generated/l10n.dart';

// Show place data in the search list.
class PlaceCard extends StatelessWidget {
  final Place _place;
  PlaceCard({Key key, Place place})
      : _place = place,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: null,
      child: SizedBox(
        height: 130.0,
        width: double.infinity,
        child: new Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 10,
                    bottom: 10,
                  ),
                  //child: //Image.asset('assets/images/mountain.jpg'),
                  child: _place.photos != null
                      ? Image.network(_place.photos[0].toLink())
                      : Image.asset('assets/images/flutter.jpg'),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _place.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: 10.0,
                        height: 10.0,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.flag,
                            color: Colors.black26,
                          ),
                          Text(S.of(context).distant("123 km")),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: Icon(Icons.comment),
                          ),
                          Expanded(
                            flex: 6,
                            child: Text(_place.user_ratings_total.toString(),
                                style: TextStyle(fontSize: 12)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: Icon(Icons.star),
                          ),
                          Expanded(
                            flex: 6,
                            child: Text(
                              _place.rating.toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
