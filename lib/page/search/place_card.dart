import 'package:flutter/material.dart';

// Show place data in the search list.
class PlaceCard extends StatefulWidget {
  PlaceCard({Key key}) : super(key: key);

  @override
  _PlaceCardState createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
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
                          left: 10, right: 10, top: 10, bottom: 10),
                      child: Image.asset('assets/images/mountain.jpg'),
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
                            Text("景點標題",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            Container(width: 10.0, height: 10.0),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.flag,
                                  color: Colors.black26,
                                ),
                                Text("距離目前位置 123 km"),
                              ],
                            ),
                          ]),
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
                                  child: Icon(Icons.location_on),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Text("456"),
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
                                  child: Icon(Icons.comment),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Text("789"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ]
                )
            )
        )
    );
  }
}
