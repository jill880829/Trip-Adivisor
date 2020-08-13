import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import "package:tripadvisor/page/schedule/commuting_time.dart";
import "package:tripadvisor/page/schedule/schedule_viewpoint_card.dart";
import 'package:tripadvisor/page/data/viewpoint_classify.dart';
import 'package:flutter/cupertino.dart';
import 'package:tripadvisor/generated/l10n.dart';

class ScheduleSingle extends StatefulWidget {
  List<Map<String, dynamic>> data;
  int count;
  ScheduleSingle({Key key, @required this.data, @required this.count})
      : super(key: key);

  @override
  _ScheduleSingleState createState() => _ScheduleSingleState();
}

class _ScheduleSingleState extends State<ScheduleSingle> {
  List<Widget> _obj = new List<Widget>();

  @override
  Widget build(BuildContext context) {
    for (var tem in widget.data) {
      _obj.add(TimelineSingle(data: tem, length: widget.data.length));
      if (tem["order"] != widget.data.length) _obj.add(TrafficSingle());
    }

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20, left: 15),
              child: Row(
                children: <Widget>[
                  Text(S.of(context).start_time + ":"),
                  Container(width: 10),
                  StartTimeBotton(),
                ],
              ),
            ),
            for (var obj in _obj) obj,
            Padding(
              padding:
                  EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
              child: RaisedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.add),
                    Container(
                      width: 10,
                    ),
                    Text(S.of(context).new_schedule),
                  ],
                ),
                //TODO:  action for add schedule
                onPressed: () {
                  print("press");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimelineSingle extends StatefulWidget {
  Map<String, dynamic> data;
  int length;

  TimelineSingle({Key key, @required this.data, @required this.length})
      : super(key: key);

  @override
  _TimelineSingleState createState() => _TimelineSingleState();
}

class _TimelineSingleState extends State<TimelineSingle> {
  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineX: 0.05,
      isFirst: (widget.data["order"] == 1),
      isLast: (widget.data["order"] == widget.length),
      rightChild: ViewPointCard(data: widget.data),
      indicatorStyle: IndicatorStyle(
        width: 35,
        //TODO: use place_id to get place's classification.
        color: ViewpointClassify.Place.color,
        iconStyle: IconStyle(
          color: Colors.white,
          iconData: ViewpointClassify.Place.icon,
        ),
      ),
      topLineStyle: const LineStyle(
        width: 5,
      ),
      bottomLineStyle: const LineStyle(
        width: 5,
      ),
    );
  }
}

//TODO: pass two places to this class to calculate the commuting time.
class TrafficSingle extends StatefulWidget {
  int length;

  TrafficSingle({Key key}) : super(key: key);

  @override
  _TrafficSingleState createState() => _TrafficSingleState();
}

class _TrafficSingleState extends State<TrafficSingle> {
  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineX: 0.05,
      hasIndicator: false,
      rightChild: CommutingTime(),
      topLineStyle: const LineStyle(
        width: 5,
      ),
      bottomLineStyle: const LineStyle(
        width: 5,
      ),
    );
  }
}

class StartTimeBotton extends StatefulWidget {
  StartTimeBotton({Key key}) : super(key: key);

  @override
  _StartTimeBottonState createState() => _StartTimeBottonState();
}

class _StartTimeBottonState extends State<StartTimeBotton> {
  List<String> clock;

  int _selectedClock = 0, _changedClock = 0;
  int _selectedHour = 8, _selectedMinute = 0;
  int _changedHour = 8, _changedMinute = 0;

  @override
  Widget build(BuildContext context) {
    clock = <String>[S.of(context).AM, S.of(context).PM];

    return RaisedButton(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 200.0,
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text(S.of(context).cancel),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: CupertinoPicker(
                              scrollController: new FixedExtentScrollController(
                                initialItem: _selectedClock,
                              ),
                              itemExtent: 32.0,
                              backgroundColor: Colors.white,
                              onSelectedItemChanged: (int index) {
                                _changedClock = index;
                              },
                              children: new List<Widget>.generate(clock.length,
                                  (int index) {
                                return new Center(
                                  child: new Text(clock[index]),
                                );
                              }),
                            ),
                          ),
                          Expanded(
                            child: CupertinoPicker(
                              scrollController: new FixedExtentScrollController(
                                initialItem: _selectedHour,
                              ),
                              itemExtent: 32.0,
                              backgroundColor: Colors.white,
                              onSelectedItemChanged: (int index) {
                                _changedHour = index;
                              },
                              children: <Widget>[
                                for (var a = 1; a <= 12; a++)
                                  Center(
                                    child: new Text(a.toString()),
                                  ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: CupertinoPicker(
                              scrollController: new FixedExtentScrollController(
                                initialItem: _selectedMinute,
                              ),
                              itemExtent: 32.0,
                              backgroundColor: Colors.white,
                              onSelectedItemChanged: (int index) {
                                _changedMinute = index;
                              },
                              children: <Widget>[
                                for (var a = 0; a <= 55; a += 5)
                                  Center(
                                    child:
                                        new Text(a.toString().padLeft(2, '0')),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    CupertinoButton(
                      child: Text(S.of(context).OK),
                      onPressed: () {
                        setState(() {
                          _selectedHour = _changedHour;
                          _selectedClock = _changedClock;
                          _selectedMinute = _changedMinute;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            });
      },
      child: Text(clock[_changedClock] +
          " " +
          (_changedHour + 1).toString() +
          ":" +
          (_changedMinute * 5).toString().padLeft(2, '0')),
    );
  }
}
