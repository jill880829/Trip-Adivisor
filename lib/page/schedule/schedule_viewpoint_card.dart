import 'package:flutter/material.dart';
import 'package:tripadvisor/generated/l10n.dart';

class ViewPointCard extends StatefulWidget {
  Map<String, dynamic> data;
  ViewPointCard({Key key, @required this.data}) : super(key: key);

  @override
  _ViewPointCardState createState() => _ViewPointCardState();
}

class _ViewPointCardState extends State<ViewPointCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              //TODO: Page include place's detail and note.
              builder: (context) => Scaffold(
                    body: Container(
                      height: 500,
                    ),
                  )),
        );
      },
      child: Card(
          child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //TODO: use place_id to get place's detail.
            Text(
              widget.data["place_id"],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            Container(
              height: 15,
            ),
            Text("台北市中正區北平西路3號100臺灣"),
            Container(
              height: 5,
            ),
            Row(
              children: <Widget>[
                //TODO: add button for time choosing
                Text(S.of(context).stay_time + ": "),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
