import 'package:flutter/material.dart';
import 'package:tripadvisor/page/search/search_main_page.dart';

void main() {
  runApp(MainScreen());
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
        body: BottomNavigationController(),
    ));
  }
}

class BottomNavigationController extends StatefulWidget {
  BottomNavigationController({Key key}) : super(key: key);

  @override
  _BottomNavigationControllerState createState() =>
      _BottomNavigationControllerState();
}

class _BottomNavigationControllerState
    extends State<BottomNavigationController> {
  int _currentIndex = 0;
  final pages = [SearchMain(), Column(), Column()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: <BottomNavigationBarItem> [
          BottomNavigationBarItem(icon: Icon(Icons.search), title: Text('景點搜尋')),
          BottomNavigationBarItem(icon: Icon(Icons.event_note), title: Text('行程規劃')),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text('個人資料')),
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


