import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripadvisor/bloc/bloc.dart';
import 'package:tripadvisor/api/api.dart';

class SearchPlaceDelegate extends SearchDelegate<Future<Widget>> {
  final Bloc<SearchEvent, SearchState> searchBloc;
  final Bloc<SearchEvent, SearchState> suggestionBloc;

  SearchPlaceDelegate(this.searchBloc)
      : suggestionBloc = SearchBloc(placeApiProvider: PlaceApiProvider());

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query != '') suggestionBloc.dispatch(SearchTextOnChanged(query));
    return BlocBuilder(
      bloc: suggestionBloc,
      builder: (context, state) {
        if (state is SearchLoadInProgress)
          return Center(
            child: CircularProgressIndicator(),
          );
        else if (state is SearchInitial)
          return ListView();
        else if (state is SearchLoadSuccess)
          return ListView(
            children: <Widget>[
              ListTile(
                title: Text('搜尋: ' + query),
                onTap: () => {
                  searchBloc.dispatch(SearchOnSubmitted(query)),
                  close(context, null),
                },
              ),
              for (var place in state.places)
                ListTile(
                  title: Text(place.name),
                  onTap: () => {
                    searchBloc.dispatch(SearchOnSubmitted(place.name)),
                    close(context, null)
                  },
                )
            ],
          );
        return Center(
          child: Text('未符合'),
        );
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    // TODO: implement appBarTheme
    return super.appBarTheme(context);
  }
}
