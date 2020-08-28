import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripadvisor/bloc/bloc.dart';

import 'package:tripadvisor/page/data/viewpoint_classify.dart';

class Filter extends StatefulWidget {
  Filter({Key key}) : super(key: key);

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        for (ViewpointClassify classify in ViewpointClassify.values)
          BlocBuilder(
            bloc: BlocProvider.of<FilterBloc>(context),
            builder: (context, state) {
              return IconButton(
                icon: Icon(
                  classify.icon,
                  color: state.show.contains(classify.type)
                      ? classify.color
                      : Colors.grey,
                ),
                onPressed: () => {
                  BlocProvider.of<SaveFavoriteBloc>(context)
                      .dispatch(FavoriteOnPressed(true)),
                  BlocProvider.of<FilterBloc>(context)
                      .dispatch(FilterOnPressed(classify.type)),
                  BlocProvider.of<SearchBloc>(context).dispatch(SearchRefresh())
                },
              );
            },
          ),
        BlocBuilder(
          bloc: BlocProvider.of<SaveFavoriteBloc>(context),
          builder: (context, state) {
            return IconButton(
              icon: Icon(
                Icons.favorite,
                color: BlocProvider.of<SaveFavoriteBloc>(context).getIsSearch ? Colors.grey : Colors.deepPurple,
              ),
              onPressed: () => {
                BlocProvider.of<SaveFavoriteBloc>(context)
                    .dispatch(FavoriteOnPressed(!BlocProvider.of<SaveFavoriteBloc>(context).getIsSearch)),
                BlocProvider.of<FilterBloc>(context).dispatch(FilterClear()),
              },
            );
          },
        ),
      ],
    );
  }
}
