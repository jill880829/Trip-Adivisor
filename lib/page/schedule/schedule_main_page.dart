import 'package:flutter/material.dart';
import 'package:tripadvisor/generated/l10n.dart';
import 'package:tripadvisor/page/schedule/schedule_travel_card.dart';

class ScheduleMain extends StatefulWidget {
  ScheduleMain({Key key}) : super(key: key);

  @override
  _ScheduleMainState createState() => _ScheduleMainState();
}

class _ScheduleMainState extends State<ScheduleMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(S.of(context).schedule),
      ),
      body: ListView.builder(
          itemCount: 8,
          itemBuilder: (context, index) {
            return TravelCard();
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          //TODO: create a new schedule
          print('press...');
        },
      ),
    );
  }
}
