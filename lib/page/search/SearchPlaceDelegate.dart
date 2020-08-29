import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripadvisor/bloc/bloc.dart';
import 'package:tripadvisor/model/place.dart';

class SearchPlaceDelegate extends SearchDelegate<Future<Widget>> {
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
    MapBloc mapBloc = BlocProvider.of<MapBloc>(context);
    if (query != '' && mapBloc.state is MapLoadSuccess) {
      final target = (mapBloc.state as MapLoadSuccess).cameraPosition.target;
      BlocProvider.of<SuggestionBloc>(context).add(
        SearchSuggestionList(
          query,
          Location(target.latitude, target.longitude),
        ),
      );
    }
    return BlocBuilder<SuggestionBloc, SuggestionState>(
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
              for (var place in state.nearby)
                ListTile(
                  title: Text(place.name),
                  onTap: () {
                    BlocProvider.of<MapBloc>(context).add(
                      MapMoving(
                        CameraPosition(
                          target: LatLng(
                            place.geometry.location.lat,
                            place.geometry.location.lng,
                          ),
                          zoom: 15,
                        ),
                      ),
                    );
                    BlocProvider.of<SearchBloc>(context).add(
                      SearchNearbyByPlace(place, 1000),
                    );
                    close(context, null);
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
