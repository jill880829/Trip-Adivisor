import 'package:flutter/material.dart';
import 'package:tripadvisor/page/search/main.dart';

import 'package:tripadvisor/generated/l10n.dart';

import 'package:tripadvisor/page/schedule/schedule_main_page.dart';

class BottomNavigationController extends StatefulWidget {
  BottomNavigationController({Key key}) : super(key: key);

  @override
  _BottomNavigationControllerState createState() =>
    _BottomNavigationControllerState();
}

class _BottomNavigationControllerState
    extends State<BottomNavigationController> {
  int _currentIndex = 0;
  final pages = [SearchMain(), ScheduleMain(), Column()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text(S.of(context).search)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note),
            title: Text(S.of(context).schedule)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text(S.of(context).account)
          ),
        ],
        fixedColor: Colors.blueAccent,
        onTap: _onItemClick,
      ),
    );
  }

  void _onItemClick(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}