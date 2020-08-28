import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tripadvisor/page/BottomNavigationController.dart';

import 'package:bloc/bloc.dart';
import 'package:tripadvisor/SimpleBlocDelegate.dart';
import 'package:tripadvisor/bloc/bloc.dart';

import 'package:tripadvisor/api/api.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tripadvisor/generated/l10n.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MainScreen());
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchBloc>(
          builder: (BuildContext context) => SearchBloc(
            placeApiProvider: PlaceApiProvider(),
          ),
        ),
        BlocProvider<NavigationBloc>(
          builder: (BuildContext context) => NavigationBloc(),
        ),
        BlocProvider<FilterBloc>(
          builder: (BuildContext context) => FilterBloc(),
        ),
        BlocProvider<DraggableListViewBloc>(
          builder: (BuildContext context) => DraggableListViewBloc(),
        ),
        BlocProvider<SaveFavoriteBloc>(
          builder: (BuildContext context) => SaveFavoriteBloc(
            placeApiProvider: PlaceApiProvider(),
          ),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: Scaffold(
          body: BottomNavigationController(),
        ),
      ),
    );
  }
}
