import 'package:flutter/material.dart';
import 'package:tripadvisor/page/schedule/schedule_single_travel.dart';

//TODO: pass data from firebase to list each travel
class TravelCard extends StatefulWidget {
  TravelCard({Key key}) : super(key: key);

  @override
  _TravelCardState createState() => _TravelCardState();
}

class _TravelCardState extends State<TravelCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ScheduleTravel()),
          );
        },
        child: SizedBox(
            height: 100.0,
            width: double.infinity,
            child: new Card(
              child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 10, top: 10, bottom: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("行程標題",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              Container(width: 10.0, height: 10.0),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.calendar_today,
                                    color: Colors.black26,
                                  ),
                                  Container(
                                    width: 8,
                                  ),
                                  Text("2020/01/01 - 2020/01/08"),
                                ],
                              ),
                            ]),
                        IconButton(icon: Icon(Icons.more_horiz)),
                      ])),
            )));
  }
}
