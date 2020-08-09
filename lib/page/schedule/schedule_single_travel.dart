import 'package:flutter/material.dart';
import 'package:tripadvisor/page/schedule/schedule_single_day.dart';
import 'package:tripadvisor/generated/l10n.dart';

class ScheduleTravel extends StatefulWidget {
  ScheduleTravel({Key key}) : super(key: key);

  @override
  _ScheduleTravelState createState() => _ScheduleTravelState();
}

class _ScheduleTravelState extends State<ScheduleTravel> {
  //TODO: get the data from firebase, and we need a new class to get those data.
  int _count = 2;
  Map<dynamic, dynamic> tem = Map<dynamic, dynamic>();

  @override
  Widget build(BuildContext context) {
    List<Widget> _scheduleday = new List.generate(
        _count,
        (int i) => new ScheduleDay(
              day: (i + 1),
            ));

    tem[1] = [
      {
        "place_id": "place1",
        "order": 1,
        "stay_time": 3600,
        "note": "note place 1"
      },
      {
        "place_id": "place2",
        "order": 2,
        "stay_time": 3600,
        "note": "note place 2"
      },
      {
        "place_id": "place3",
        "order": 3,
        "stay_time": 3600,
        "note": "note place 3"
      },
      {
        "place_id": "place4",
        "order": 4,
        "stay_time": 3600,
        "note": "note place 4"
      },
      {
        "place_id": "place5",
        "order": 5,
        "stay_time": 3600,
        "note": "note place 5"
      },
    ];

    tem[2] = [
      {
        "place_id": "place2_1",
        "order": 1,
        "stay_time": 3600,
        "note": "note place2_ 1"
      },
      {
        "place_id": "place2_2",
        "order": 2,
        "stay_time": 3600,
        "note": "note place2_ 2"
      },
      {
        "place_id": "place2_3",
        "order": 3,
        "stay_time": 3600,
        "note": "note place2_ 3"
      },
      {
        "place_id": "place2_4",
        "order": 4,
        "stay_time": 3600,
        "note": "note place2_ 4"
      },
      {
        "place_id": "place2_5",
        "order": 5,
        "stay_time": 3600,
        "note": "note place2_ 5"
      },
    ];

    return Scaffold(
      body: DefaultTabController(
        length: _count,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverSafeArea(
                  top: false,
                  sliver: SliverAppBar(
                    title: Text("test"),
                    floating: true,
                    pinned: true,
                    snap: false,
                    forceElevated: innerBoxIsScrolled,
                    bottom: TabBar(
                      unselectedLabelColor: Colors.white.withOpacity(0.3),
                      indicatorColor: Colors.white,
                      isScrollable: true,
                      tabs: _scheduleday,
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: <Widget>[
              for (var key in tem.keys)
                ScheduleSingle(
                  data: tem[key],
                  count: key,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScheduleDay extends StatefulWidget {
  int day;
  ScheduleDay({Key key, this.day}) : super(key: key);

  @override
  _ScheduleDayState createState() => _ScheduleDayState();
}

class _ScheduleDayState extends State<ScheduleDay> {
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        padding: EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
        width: 130,
        height: 250,
        child: Column(
          children: <Widget>[
            //TODO: get data from firebase and show each day.
            Text("1/1", style: TextStyle(color: Colors.white70)),
            Text(S.of(context).schedule_day(widget.day.toString())),
          ],
        ),
      ),
    );
  }
}
