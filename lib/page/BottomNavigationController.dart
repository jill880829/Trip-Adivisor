import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripadvisor/bloc/bloc.dart';

import 'package:tripadvisor/generated/l10n.dart';

import 'package:tripadvisor/page/search/main.dart';
import 'package:tripadvisor/page/schedule/schedule_main_page.dart';

class BottomNavigationController extends StatefulWidget {
  BottomNavigationController({Key key}) : super(key: key);

  @override
  _BottomNavigationControllerState createState() =>
      _BottomNavigationControllerState();
}

class _BottomNavigationControllerState
    extends State<BottomNavigationController> {
  final barItems = [
    {
      "page": SearchMain(),
      "icon": Icons.search,
      "title": (context) => S.of(context).search,
    },
    {
      "page": ScheduleMain(),
      "icon": Icons.event_note,
      "title": (context) => S.of(context).schedule,
    },
    {
      "page": Column(),
      "icon": Icons.account_circle,
      "title": (context) => S.of(context).account,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<NavigationBloc>(context),
      builder: (context, state) {
        return Scaffold(
          body: barItems[state.getIndex()]["page"],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.getIndex(),
            items: <BottomNavigationBarItem>[
              for (var barItem in barItems)
                BottomNavigationBarItem(
                  icon: Icon(barItem["icon"]),
                  title: Text((barItem["title"] as Function)(context)),
                )
            ],
            fixedColor: Colors.blueAccent,
            onTap: (index) => BlocProvider.of<NavigationBloc>(context)
                .dispatch(NavigationOnTap(index)),
          ),
        );
      },
    );
  }
}
