import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tripadvisor/page/BottomNavigationController.dart';

import 'package:bloc/bloc.dart';
import 'package:tripadvisor/SimpleBlocDelegate.dart';
import 'package:tripadvisor/bloc/bloc.dart';

import 'package:tripadvisor/api/api.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MainScreen());
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          builder: (BuildContext context) => 
            SearchBloc(placeApiProvider: PlaceApiProvider()),
        )
      ],
      child: MaterialApp(
        home: Scaffold(
          body: BottomNavigationController(),
        )
      )
    );
  }
}