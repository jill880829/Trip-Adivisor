import 'package:flutter/material.dart';
import 'package:tripadvisor/generated/l10n.dart';

//TODO: This class have to connect with google map api to calculate commuting time.
class CommutingTime extends StatefulWidget {
  CommutingTime({Key key}) : super(key: key);

  @override
  _CommutingTimeState createState() => _CommutingTimeState();
}

class _CommutingTimeState extends State<CommutingTime> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      child: Row(
        children: <Widget>[
          Icon(Icons.directions_bus),
          Container(width: 10),
          Text(S.of(context).about + " 30 " + S.of(context).minute),
        ],
      ),
    );
  }
}
